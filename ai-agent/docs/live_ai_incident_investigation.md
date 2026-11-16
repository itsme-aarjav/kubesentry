# Live AI Incident Investigation & Grounded RAG Proof

- **Target Agent**: `k8s-incident-investigator` (Version 7)
- **Foundry Project**: `aif-kubesentry-dev/kubesentry-project`
- **Model Deployment**: `gpt-5-mini` (100k TPM)
- **Execution Latency**: 38.38 seconds
- **Response Status**: HTTP 200 OK
- **Language**: English
- **Tools Invoked**:
  1. `kubernetes-cluster` MCP Server (`https://mcp.20-19-153-146.nip.io/k8s/mcp`)
  2. `prometheus-metrics` MCP Server (`https://mcp.20-19-153-146.nip.io/prometheus/mcp`)
  3. `azure_ai_search` RAG Index (`kubesentry-index` on `srch-kubesentry-dev.search.windows.net`)

---

## 1. Investigation Request Prompt

```text
An incident is reported in the dev namespace. The application portfolio-app seems degraded. Investigate the Kubernetes cluster and Prometheus metrics, consult the knowledge base for runbooks and context, and identify the root cause, evidence, impact, and recommended fix.
```

---

## 2. Model Output & Verified Evidence

### Root Cause
The external load‑balancer / Ingress health probe is probing a path that the Ingress/NGINX returns 404 for (health-probe → unhealthy), so the cloud load balancer marks the backend as unhealthy and drops external traffic — while the portfolio-app Pod and Service are healthy inside the cluster.

### Evidence
- **Pod status (Kubernetes)**: `portfolio-app-b4f4bfd8d-l424w` is Running and Ready in namespace `dev` (kubectl pods list): "1/1 Running" (`pods_list_in_namespace`).
- **Pod readiness/liveness configuration (`kubectl get pod`)**: readinessProbe → HTTP GET `/actuator/health/readiness` port 8080; livenessProbe → `/actuator/health/liveness` (`pods_get`).
- **Application logs**: Spring Boot started, Tomcat listening on port 8080; no application startup errors in container logs (`pods_log`).
- **Service endpoints**: Service `portfolio-app` has endpoint `10.10.1.8:8080`, confirming kube Service → Pod routing is OK (`resources_list Endpoints`).
- **Kubernetes events**: No warning events found in `dev` (`events_list` returned none).
- **Prometheus metrics**:
  - Request rate for the pod: `sum(rate(http_server_requests_seconds_count{pod=~"portfolio-app.*"}[5m])) by (pod) = 0.2 rps` (`mcp_prometheus-metrics.execute_query`).
  - 95th percentile latency: `histogram_quantile(0.95, ...) ≈ 0.0029 s` (`mcp_prometheus-metrics.execute_query`).
  - Container readiness: `kube_pod_container_status_ready = 1` (`mcp_prometheus-metrics.execute_query`).
- **Knowledge-base runbook citation (RAG grounding)**: Azure Load Balancer probe configuration runbook in `agent-knowledge.md` documents this failure mode and recommends aligning LB/Ingress probe paths with application readiness endpoints 【43:0†source】.

### Impact
- **User-facing / ingress traffic**: External requests observed as failing or timing out ("application degraded") even though the application Pod and Service are healthy internally.
- **Blast radius**: Single replica in `dev` → all external traffic to `portfolio-app` in `dev` affected while the cloud LB marks backends unhealthy.
- **Application health**: Internal metrics and Pod health are normal (low latency, ready), proving an external routing/health-check issue rather than an application crash or resource exhaustion.

### Recommended Fix
1. **Verify Ingress / Azure Load Balancer health-probe configuration (diagnose-only guidance)**:
   - Check Ingress / Service annotations and the Azure LB health probe path configured for the backend.
   - If probing `/`, ensure NGINX/Ingress responds 200 for that path; otherwise change the probe to use a path returning 200.
2. **Update LB/Ingress health probe to known readiness path**:
   - Point probe to `/actuator/health/readiness` or a lightweight `/healthz` endpoint returning HTTP 200.
   - For Azure Load Balancer + Kubernetes Service, set annotation:
     `service.beta.kubernetes.io/azure-load-balancer-health-probe-request-path: "/actuator/health/readiness"`
   - Reference: Documented runbook pattern in project knowledge base 【43:0†source】.
3. **Robustness improvements**:
   - Increase probe `timeoutSeconds` from 1s to 2-3s to avoid false negatives under transient latency.
4. **Post-fix verification**:
   - Confirm Azure LB / Ingress backends become healthy.
   - Confirm external request success rate increases and `kube_pod_container_status_ready` remains 1.

*Diagnostic Guardrail Notice: The Agent operates strictly in read-only mode and performs zero mutating actions on the cluster.*

---

## 3. Verified Visual Screenshots

- [Investigation Evidence Screenshot](images/live_foundry_investigation_evidence.png)
- [Investigation Remediation & Summary Screenshot](images/live_foundry_investigation_remediation.png)
- [Investigation Query & MCP Tools Execution](images/live_foundry_investigation_query.png)
