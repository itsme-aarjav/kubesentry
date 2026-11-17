# Live Pipeline #3077621954 — Security Verification & AI Review

> [!NOTE] Current Verification Status & Pipeline Provenance
> - **Primary Verified Pipeline**: [#3077621954](https://gitlab.com/itsme-aarjav/kubesentry/-/pipelines/3077621954) (Job `#18095363667`, Commit `7a01e939`, Branch `main`)
> - **Predecessor Baseline**: [#3076259725](https://gitlab.com/itsme-aarjav/kubesentry/-/pipelines/3076259725) (Job `#18086209361`, Commit `9c386b25`)
> - **Active Container Image**: `acrkubesentrydev.azurecr.io/portfolio-app:7a01e939` (Spring Boot 4.0.9, Java 21)
> - **Verified Image Digest**: `sha256:07eeecae39a70b91563a8608ce01c0aa64d1be8e6d3a39b855b89642e636d795`
> - **Trivy Container Scan Gate**: **PASSED (0 CRITICAL, 0 HIGH)** — Hard blocking gate enforced via `--exit-code 1`
> - **Semgrep SAST Scan**: **PASSED (0 Vulnerabilities)** — Clean static analysis scan
> - **Syft SBOM & Cosign Signature**: **VERIFIED** — Keyless OCI 1.1 referrers published to ACR
> - **AI Security Review Status**: **PASSED & VERIFIED (English v7 Agent)** — Pushgateway HTTP 200, 52.3s duration

---

## 1. Verified Security Scan Results (Pipeline #3077621954)

### Container Image Vulnerability Scan (Trivy)
- **Scanner**: Trivy v0.66.0 (Job `#18095363663`)
- **Policy**: `--exit-code 1 --severity HIGH,CRITICAL`
- **Result**: **0 Vulnerabilities Found** (0 Critical, 0 High).
- **Security Boundary**: The container scan executes before the image is pushed to ACR. Any detected High or Critical vulnerability immediately terminates the pipeline with exit code 1.

### Static Application Security Testing (Semgrep SAST)
- **Scanner**: Semgrep OSS (GitLab SAST template, Job `#18095363660`)
- **Policy**: GitLab SAST ruleset with `allow_failure: true`
- **Result**: **Clean Pass (0 Findings)**.

### Supply Chain Integrity (Syft & Sigstore Cosign)
- **SBOM**: Full SPDX JSON SBOM (`sbom.json`) generated from the container image and published as a pipeline artifact (Job `#18095363666`).
- **Signing**: Keyless OIDC signature generated using Sigstore Cosign with GitLab CI identity federation.
- **ACR Artifacts**: Signature (`.sig`) and SBOM attestation (`.att`) attached directly to image digest in Azure Container Registry (`acrkubesentrydev.azurecr.io`).

---

## 2. Authentic Live AI Security Review Execution (Pipeline #3077621954 — Version 7 English)

- **GitLab Pipeline**: [#3077621954](https://gitlab.com/itsme-aarjav/kubesentry/-/pipelines/3077621954)
- **Job ID**: `#18095363667` (`ai_security_review`)
- **Commit SHA**: `7a01e939269631493670e0247629723485a8e875`
- **Foundry Agent**: `k8s-incident-investigator` (Version 7)
- **Model**: `gpt-5-mini` on Azure AI Foundry
- **Duration**: **52.3 seconds**
- **Prometheus Pushgateway**: **HTTP 200** (metrics pushed: `ai_agent_call_total{status="success"} 1`, `ai_agent_call_duration_seconds 52.30`)
- **Grounded RAG Knowledge Base**: `https://srch-kubesentry-dev.search.windows.net/` (Index: `kubesentry-index`, Storage: `stfkubesentrydev`, Source: `agent-knowledge.md`)
- **Language**: **100% English**

### Executive Review Summary
The v7 Azure AI Foundry Agent performed an automated multi-step investigation:
1. **Tool Discovery**: Queried MCP tools (`kubernetes-cluster` and `prometheus-metrics`).
2. **Telemetry Correlation**: Correlated the clean Trivy scan and zero-finding SAST report against the SPDX JSON SBOM.
3. **Supply Chain Evaluation**: Evaluated third-party dependencies in the SBOM excerpt, identifying that while Trivy and SAST reported 0 HIGH/CRITICAL CVEs, full end-to-end dependency correlation is recommended prior to production promotion.
4. **Deployment Recommendation**: Issued an advisory NO-GO recommendation as a precautionary stance due to the truncated SBOM excerpt in the prompt, demonstrating conservative AI governance.

<details>
<summary>Click to expand Pipeline #3077621954 raw JSON artifact</summary>

```json
[
  {
    "type": "mcp_list_tools",
    "id": "mcpl_067cbc1b188a8a7e006afc007855cc81968d895f8b884ac247",
    "agent_reference": {
      "type": "agent_reference",
      "name": "k8s-incident-investigator",
      "version": "7"
    },
    "response_id": "resp_067cbc1b188a8a7e006afc0078407c8196825c976de2705bd8",
    "server_label": "kubernetes-cluster",
    "tools": [
      {
        "name": "events_list",
        "description": "List Kubernetes events (warnings, errors, state changes) for debugging and troubleshooting in the current cluster from all namespaces",
        "input_schema": {
          "type": "object",
          "properties": {
            "namespace": {
              "type": "string",
              "description": "Optional Namespace to retrieve the events from. If not provided, will list events from all namespaces",
              "properties": {},
              "required": []
            }
          },
          "required": []
        },
        "annotations": {}
      },
      {
        "name": "namespaces_list",
        "description": "List all the Kubernetes namespaces in the current cluster",
        "input_schema": {
          "type": "object",
          "properties": {},
          "required": []
        },
        "annotations": {}
      },
      {
        "name": "nodes_log",
        "description": "Get logs from a Kubernetes node (kubelet, kube-proxy, or other system logs). This accesses node logs through the Kubernetes API proxy to the kubelet",
        "input_schema": {
          "type": "object",
          "properties": {
            "name": {
              "type": "string",
              "description": "Name of the node to get logs from",
              "properties": {},
              "required": []
            },
            "query": {
              "type": "string",
              "description": "query specifies services(s) or files from which to return logs (required). Example: \"kubelet\" to fetch kubelet logs, \"/<log-file-name>\" to fetch a specific log file from the node (e.g., \"/var/log/kubelet.log\" or \"/var/log/kube-proxy.log\")",
              "properties": {},
              "required": []
            },
            "tailLines": {
              "type": "integer",
              "description": "Number of lines to retrieve from the end of the logs (Optional, 0 means all logs)",
              "properties": {},
              "default": 100,
              "required": []
            }
          },
          "required": [
            "name",
            "query"
          ]
        },
        "annotations": {}
      },
      {
        "name": "nodes_stats_summary",
        "description": "Get detailed resource usage statistics from a Kubernetes node via the kubelet's Summary API. Provides comprehensive metrics including CPU, memory, filesystem, and network usage at the node, pod, and container levels. On systems with cgroup v2 and kernel 4.20+, also includes PSI (Pressure Stall Information) metrics that show resource pressure for CPU, memory, and I/O. See https://kubernetes.io/docs/reference/instrumentation/understand-psi-metrics/ for details on PSI metrics",
        "input_schema": {
          "type": "object",
          "properties": {
            "name": {
              "type": "string",
              "description": "Name of the node to get stats from",
              "properties": {},
              "required": []
            }
          },
          "required": [
            "name"
          ]
        },
        "annotations": {}
      },
      {
        "name": "nodes_top",
        "description": "List the resource consumption (CPU and memory) as recorded by the Kubernetes Metrics Server for the specified Kubernetes Nodes or all nodes in the cluster",
        "input_schema": {
          "type": "object",
          "properties": {
            "label_selector": {
              "type": "string",
              "description": "Kubernetes label selector (e.g. 'node-role.kubernetes.io/worker=') to filter nodes by label (Optional, only applicable when name is not provided)",
              "properties": {},
              "required": []
            },
            "name": {
              "type": "string",
              "description": "Name of the Node to get the resource consumption from (Optional, all Nodes if not provided)",
              "properties": {},
              "required": []
            }
          },
          "required": []
        },
        "annotations": {}
      },
      {
        "name": "pods_get",
        "description": "Get a Kubernetes Pod in the current or provided namespace with the provided name",
        "input_schema": {
          "type": "object",
          "properties": {
            "name": {
              "type": "string",
              "description": "Name of the Pod",
              "properties": {},
              "required": []
            },
            "namespace": {
              "type": "string",
              "description": "Namespace to get the Pod from",
              "properties": {},
              "required": []
            }
          },
          "required": [
            "name"
          ]
        },
        "annotations": {}
      },
      {
        "name": "pods_list",
        "description": "List all the Kubernetes pods in the current cluster from all namespaces",
        "input_schema": {
          "type": "object",
          "properties": {
            "fieldSelector": {
              "type": "string",
              "description": "Optional Kubernetes field selector to filter pods by field values (e.g. 'status.phase=Running', 'spec.nodeName=node1'). Supported fields: metadata.name, metadata.namespace, spec.nodeName, spec.restartPolicy, spec.schedulerName, spec.serviceAccountName, status.phase (Pending/Running/Succeeded/Failed/Unknown), status.podIP, status.nominatedNodeName. Note: CrashLoopBackOff is a container state, not a pod phase, so it cannot be filtered directly. See https://kubernetes.io/docs/concepts/overview/working-with-objects/field-selectors/",
              "properties": {},
              "required": []
            },
            "labelSelector": {
              "type": "string",
              "description": "Optional Kubernetes label selector (e.g. 'app=myapp,env=prod' or 'app in (myapp,yourapp)'), use this option when you want to filter the pods by label",
              "properties": {},
              "required": []
            }
          },
          "required": []
        },
        "annotations": {}
      },
      {
        "name": "pods_list_in_namespace",
        "description": "List all the Kubernetes pods in the specified namespace in the current cluster",
        "input_schema": {
          "type": "object",
          "properties": {
            "fieldSelector": {
              "type": "string",
              "description": "Optional Kubernetes field selector to filter pods by field values (e.g. 'status.phase=Running', 'spec.nodeName=node1'). Supported fields: metadata.name, metadata.namespace, spec.nodeName, spec.restartPolicy, spec.schedulerName, spec.serviceAccountName, status.phase (Pending/Running/Succeeded/Failed/Unknown), status.podIP, status.nominatedNodeName. Note: CrashLoopBackOff is a container state, not a pod phase, so it cannot be filtered directly. See https://kubernetes.io/docs/concepts/overview/working-with-objects/field-selectors/",
              "properties": {},
              "required": []
            },
            "labelSelector": {
              "type": "string",
              "description": "Optional Kubernetes label selector (e.g. 'app=myapp,env=prod' or 'app in (myapp,yourapp)'), use this option when you want to filter the pods by label",
              "properties": {},
              "required": []
            },
            "namespace": {
              "type": "string",
              "description": "Namespace to list pods from",
              "properties": {},
              "required": []
            }
          },
          "required": [
            "namespace"
          ]
        },
        "annotations": {}
      },
      {
        "name": "pods_log",
        "description": "Get the logs of a Kubernetes Pod in the current or provided namespace with the provided name",
        "input_schema": {
          "type": "object",
          "properties": {
            "container": {
              "type": "string",
              "description": "Name of the Pod container to get the logs from (Optional)",
              "properties": {},
              "required": []
            },
            "name": {
              "type": "string",
              "description": "Name of the Pod to get the logs from",
              "properties": {},
              "required": []
            },
            "namespace": {
              "type": "string",
              "description": "Namespace to get the Pod logs from",
              "properties": {},
              "required": []
            },
            "previous": {
              "type": "boolean",
              "description": "Return previous terminated container logs (Optional)",
              "properties": {},
              "required": []
            },
            "tail": {
              "type": "integer",
              "description": "Number of lines to retrieve from the end of the logs (Optional, default: 100)",
              "properties": {},
              "default": 100,
              "required": []
            }
          },
          "required": [
            "name"
          ]
        },
        "annotations": {}
      },
      {
        "name": "pods_top",
        "description": "List the resource consumption (CPU and memory) as recorded by the Kubernetes Metrics Server for the specified Kubernetes Pods in the all namespaces, the provided namespace, or the current namespace",
        "input_schema": {
          "type": "object",
          "properties": {
            "all_namespaces": {
              "type": "boolean",
              "description": "If true, list the resource consumption for all Pods in all namespaces. If false, list the resource consumption for Pods in the provided namespace or the current namespace",
              "properties": {},
              "default": true,
              "required": []
            },
            "label_selector": {
              "type": "string",
              "description": "Kubernetes label selector (e.g. 'app=myapp,env=prod' or 'app in (myapp,yourapp)'), use this option when you want to filter the pods by label (Optional, only applicable when name is not provided)",
              "properties": {},
              "required": []
            },
            "name": {
              "type": "string",
              "description": "Name of the Pod to get the resource consumption from (Optional, all Pods in the namespace if not provided)",
              "properties": {},
              "required": []
            },
            "namespace": {
              "type": "string",
              "description": "Namespace to get the Pods resource consumption from (Optional, current namespace if not provided and all_namespaces is false)",
              "properties": {},
              "required": []
            }
          },
          "required": []
        },
        "annotations": {}
      },
      {
        "name": "resources_get",
        "description": "Get a Kubernetes resource in the current cluster by providing its apiVersion, kind, optionally the namespace, and its name\n(common apiVersion and kind include: v1 Pod, v1 Service, v1 Node, apps/v1 Deployment, networking.k8s.io/v1 Ingress)",
        "input_schema": {
          "type": "object",
          "properties": {
            "apiVersion": {
              "type": "string",
              "description": "apiVersion of the resource (examples of valid apiVersion are: v1, apps/v1, networking.k8s.io/v1)",
              "properties": {},
              "required": []
            },
            "kind": {
              "type": "string",
              "description": "kind of the resource (examples of valid kind are: Pod, Service, Deployment, Ingress)",
              "properties": {},
              "required": []
            },
            "name": {
              "type": "string",
              "description": "Name of the resource",
              "properties": {},
              "required": []
            },
            "namespace": {
              "type": "string",
              "description": "Optional Namespace to retrieve the namespaced resource from (ignored in case of cluster scoped resources). If not provided, will get resource from configured namespace",
              "properties": {},
              "required": []
            }
          },
          "required": [
            "apiVersion",
            "kind",
            "name"
          ]
        },
        "annotations": {}
      },
      {
        "name": "resources_list",
        "description": "List Kubernetes resources and objects in the current cluster by providing their apiVersion and kind and optionally the namespace and label selector\n(common apiVersion and kind include: v1 Pod, v1 Service, v1 Node, apps/v1 Deployment, networking.k8s.io/v1 Ingress)",
        "input_schema": {
          "type": "object",
          "properties": {
            "apiVersion": {
              "type": "string",
              "description": "apiVersion of the resources (examples of valid apiVersion are: v1, apps/v1, networking.k8s.io/v1)",
              "properties": {},
              "required": []
            },
            "fieldSelector": {
              "type": "string",
              "description": "Optional Kubernetes field selector to filter resources by field values (e.g. 'status.phase=Running', 'metadata.name=myresource'). Supported fields vary by resource type. For Pods: metadata.name, metadata.namespace, spec.nodeName, spec.restartPolicy, spec.schedulerName, spec.serviceAccountName, status.phase (Pending/Running/Succeeded/Failed/Unknown), status.podIP, status.nominatedNodeName. See https://kubernetes.io/docs/concepts/overview/working-with-objects/field-selectors/",
              "properties": {},
              "required": []
            },
            "kind": {
              "type": "string",
              "description": "kind of the resources (examples of valid kind are: Pod, Service, Deployment, Ingress)",
              "properties": {},
              "required": []
            },
            "labelSelector": {
              "type": "string",
              "description": "Optional Kubernetes label selector (e.g. 'app=myapp,env=prod' or 'app in (myapp,yourapp)'), use this option when you want to filter the resources by label",
              "properties": {},
              "required": []
            },
            "namespace": {
              "type": "string",
              "description": "Optional Namespace to retrieve the namespaced resources from (ignored in case of cluster scoped resources). If not provided, will list resources from all namespaces",
              "properties": {},
              "required": []
            }
          },
          "required": [
            "apiVersion",
            "kind"
          ]
        },
        "annotations": {}
      }
    ]
  },
  {
    "type": "mcp_list_tools",
    "id": "mcpl_067cbc1b188a8a7e006afc007857848196a407cc55e6fc60a9",
    "agent_reference": {
      "type": "agent_reference",
      "name": "k8s-incident-investigator",
      "version": "7"
    },
    "response_id": "resp_067cbc1b188a8a7e006afc0078407c8196825c976de2705bd8",
    "server_label": "prometheus-metrics",
    "tools": [
      {
        "name": "health_check",
        "description": "Health check endpoint for container monitoring and status verification",
        "input_schema": {
          "type": "object",
          "properties": {},
          "required": [],
          "additionalProperties": false
        },
        "annotations": {}
      },
      {
        "name": "execute_query",
        "description": "Execute a PromQL instant query against Prometheus",
        "input_schema": {
          "type": "object",
          "properties": {
            "query": {
              "type": "string",
              "properties": {},
              "required": []
            },
            "time": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "null"
                }
              ]
            }
          },
          "required": [
            "query"
          ],
          "additionalProperties": false
        },
        "annotations": {}
      },
      {
        "name": "execute_range_query",
        "description": "Execute a PromQL range query with start time, end time, and step interval",
        "input_schema": {
          "type": "object",
          "properties": {
            "query": {
              "type": "string",
              "properties": {},
              "required": []
            },
            "start": {
              "type": "string",
              "properties": {},
              "required": []
            },
            "end": {
              "type": "string",
              "properties": {},
              "required": []
            },
            "step": {
              "type": "string",
              "properties": {},
              "required": []
            }
          },
          "required": [
            "query",
            "start",
            "end",
            "step"
          ],
          "additionalProperties": false
        },
        "annotations": {}
      },
      {
        "name": "list_metrics",
        "description": "List all available metrics in Prometheus with optional pagination support",
        "input_schema": {
          "type": "object",
          "properties": {
            "limit": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "integer"
                },
                {
                  "type": "null"
                }
              ]
            },
            "offset": {
              "type": "integer",
              "properties": {},
              "default": 0,
              "required": []
            },
            "filter_pattern": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "null"
                }
              ]
            },
            "refresh_cache": {
              "type": "boolean",
              "properties": {},
              "default": false,
              "required": []
            }
          },
          "required": [],
          "additionalProperties": false
        },
        "annotations": {}
      },
      {
        "name": "get_metric_metadata",
        "description": "Get metadata (type, help, unit) for metrics. Returns all metric metadata when no metric name is provided. Use filter_pattern to search metric names and descriptions.",
        "input_schema": {
          "type": "object",
          "properties": {
            "metric": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "null"
                }
              ]
            },
            "filter_pattern": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "null"
                }
              ]
            },
            "limit": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "integer"
                },
                {
                  "type": "null"
                }
              ]
            },
            "offset": {
              "type": "integer",
              "properties": {},
              "default": 0,
              "required": []
            }
          },
          "required": [],
          "additionalProperties": false
        },
        "annotations": {}
      },
      {
        "name": "get_targets",
        "description": "Get scrape targets, with state/pool filtering and optional pagination",
        "input_schema": {
          "type": "object",
          "properties": {
            "state": {
              "type": "string",
              "properties": {},
              "default": "active",
              "required": []
            },
            "scrape_pool": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "null"
                }
              ]
            },
            "limit": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "integer"
                },
                {
                  "type": "null"
                }
              ]
            },
            "offset": {
              "type": "integer",
              "properties": {},
              "default": 0,
              "required": []
            }
          },
          "required": [],
          "additionalProperties": false
        },
        "annotations": {}
      }
    ]
  },
  {
    "type": "reasoning",
    "id": "rs_067cbc1b188a8a7e006afc0079074c8196ae9c1e097621c074",
    "agent_reference": {
      "type": "agent_reference",
      "name": "k8s-incident-investigator",
      "version": "7"
    },
    "response_id": "resp_067cbc1b188a8a7e006afc0078407c8196825c976de2705bd8",
    "encrypted_content": "gAAAAABq_ACM11aGubOqJXZVQKvin0MUEyRFGJHyca6k3WGcLW5my_hFTVFGRcx5CzokiTVXwfyQRnHHc0PFZlLioxOHqmVxy1Cegf8DbEAij5CG1X9qXQiAQwoGcnTvi5UNVY0KpuhAvSdyGcTIxJEwfG1VA0Dcqbsob6rE4ISnKkmj5Ox3YDB8yiwORukOzsPpTYTJ1j9VBNguZdMmZENYtk5WSNS0qfsRGngImInstbbVMgS52xY2QzX9cG4WkByX9ifE1XJuJoWwZLXF0s3m8LonCnL1VyWJiVhNNj4gwCjoVgNPF6sJECAkYuVnHo7sBRO4WUCIqHV_d9jmzEQlpCWw061GittBMIkonjZ3fJP3flZEIZ-GBVduH-z9MjhL3WhOGaUfmnY72kg_xPx_Rf-Bq16QasY4Os4Pq8DAecxgOEdifLquExAjsxpVdifQKaHwy9mKa1Eg0Hv1oKL2jZgfTRwfyJgW3l1PU0luG1_-6cz80_MY8RFoGoQCVfQ-HNFajgIPDVsdknvlqm4aBFrd2dV6ci1ZkPNlQ7xpflrwLsyYecte_f8oSCamw0D4_bUDrKaxKxZbd2_EigP6LxJbZWKJvQBfDhnwE4pHt46zPTjWrzIaO3jXS8ih5_fP3G4iKyEo1KwoaBb6olEGm3Poo3lNrGCNhNSGWayhsJCE0GHBZYZ1DABfCH_fj7zGg37rkKIPi7xtPPDGZrCbAfH2fDFA1NCYG4nyOREdwMp6Umn4Bsekq_FMqRunqNL-kZvDWkyNvYIQULDBMnt0BU3yLr2NM9KT8K_ZSKuoFmcHSPbX1SatJVMTIG5mzyIXOug1xu3bL-1DtFFtUFHxTM_3jpBQ3j9ZUzHYkq5rOx4OXlrwKRVof6Rg62msV9Ot5RGfVOr8swAZtV4pxnaocazioaQOhkyirHX10eN_G_nV2g8mv_IC2asyk0eo4bn6Njf9AIn6dBVzJr_IfSsmk43XwoXLulBOUlm4IKUawSTJd1PJ0b83fGpBs8ZQKSFDwX3Duc727AiCcWM-qq2TFeg0Zm2uvLsDLjkHibLA94zToNxg1g855zlQOzMUdiumBkZvQ0i3YF3BSydVoKdEJt8bugYu2GlNkEOUYQipmDHVLjUpkcRB71i8ylym-UPyuoee8WZ1mv4DdbstlRIOtyFh4XACm-27clnljSnLY9PnrQ-1BFsswk0ALO5A8xv8Ssbpq1xIMY_ZYNA_5lP-xqQ7KUdznrMDgQjEkVgbyr7vwK_585kHz09zC9e7S0uRiM_-n53zcsZ1AwntU5cHk8OvmJUQLkvUKYEYBdR8XRuz69nHseBb2cB__c3ohsNiQnrNQu4DpcCsiXcdZGEm9fAUsrl3dUjMcLRngAGUvzH8lEBUF172EMqSZoGZ-mcsUVTskb3JGATEWU6Cjim0BNMDQmFlSoWQxo4g9ttQiUW8W9J98_WYo-qL2STPoXXXMYQm9tRki9zAnV5H-wP7wTJvA0KYGy5Iyi5pyvYQRcibp9WaIFauQIG_Reahhbzb2mlaFNEF6LRR57S_dnzVh3_6OZ-WowCvdAIDPARgQv_PLAz0M31pJHU8XdRbwmf7cKA67s0wBbo9bvo81Ncc_mcne0oF4PL6jF2b8qPQKofV1wGsflHnJ5C0AGE91BcxkO-kYgQXXhGS53a26MFHPIO5AnD39zc-vXpP0JNg8m8tMfcdVSRxpJ8zGBD3dBF5aHs1bbNQHNsUCSQzwzxy2C_JsFDUT8mHYSTf8Kwb9DW_G5z8r4tB7zXYMZsUrx2j441BWlHkHxF4lqyjfhlm6d-S5oq7YjJMMUe52eDwX4WdWd4GMafKhUpgvie-6d4Nqgvh4v08zHj2eYqP-kk5QAxi9Q5XjrTKpSbMHOpFVgafbKQ6BBDp1YtVqrSvp8qeGJkwG3xUCsBF6CMbcxhFBVPv_50KXMIjvrhghJDrXUFN-9GgIq_wxw6WTS8Wbkxkwrcv07UKrA4Oh5JUfhgEiwzBphMZUtat9uJT__051DML4MvQtbqt0k3Q_9BbAHZ3bvoaq2TEbLvggYmb0g3plD5WCxiiZ5mv4cvseD_xS0lCXXnisBx9mZMiIaMSiSAk2AH29JD2UBl7DDbt3tP852O7Opt23LjB-IeqzBhL2VyFczyDANMoyG6ay9TALNna514D63W8P6ziSwSEW68XtVC0oF-xSF76tHo_3P0egp3jDUgHdRfJsSxiHGErdHMSUbCPudo0Ol7Biwpw-Nuv_BAWEuT0hf29m8GAVts18qr2N4aHrQsSBn3iqEjmhh40W0_TLXoHvlVOcwsONNg8K5HPUzfzVhzAWGRBt0clnJl6YfauoerfvSVlW_MhQByxzAEmwCyLyNDSZvY8NwvRhcjbYZbmNsclMuQPA84K314EZUgoy-KB8oP9R4IgvS9g4WOoUKrPeNybjYhKir9zXyQIDDGzVwDym8TKHprEAj1J4ai1Jsk_90yHlE1gWbBWa1nKOxre4P-1Jcg_4oi4xgs6bQrXts7uW9_jA097gbR2CtzwhqvArYRo5T2rLcnywNPPKZ-db14x9v5qDIzaWGhBI3kA1yIsbHCp4gQqz7unsES-ki2dUm-3qAmc0_jl0IHKx8zeWgtNgin3B6beeSiPAjuE5OjC4aHjV_MJb4Jdla4zV1DtFpgajY6UiO2KQQ89gnJ9K7W_UR72XEyYtVwUkt_mBdAGN2j7UGadmJDyPfJ3XJIhfsln3QgCVfWQ5eam3PJFZ3tlhmecI-ih7lCmKaGelK7VGH7AM1ng2aV9mwTLxh1rDTj51umIANkjKJJRldzZixCl2JuE6qsRbXYO44IH2HGxzcA-JtA2QCso_SpWdMUstsEYD34Ij3hmNirdAyPm84cpqJUF2lbt-WaQuqgxCakPOTNTFUu2Izmr7Uai-Jy2SY3LhmrLJTVdhIqGOFsnA30T2o3TpED0YoSaNAvOEYz-ZCnISVDs-Yc2fbNhTRuM3xiEPtRLAhZ0D406adNBYA3T3_FF7XBshzXaGL6MIUezGHZvR1IAAPYZYMMxYG5oPXGHoSwijV8H6b6io040SQeLLkzzO8c1ovYmLceNwPKmyJ5Cch_d10mEJLl3JthHwa_eqAqw1z4eGC77hbw3FQwGZ3g-4MtkNX-0EMXz7QNmUbjMyQb1sIY8RFl3uGObINWhbVduzvjFEU7NeCxZ5MHrbEjs-zblJ3Hexc5Ps-uk_kXV1d5AtyQId9DUsK18iO6hhvUiXrVeaBfLAfCgHhwnjxhR9Fhl4OzsbphNoT_FQwZtgv-Br5_vbNxvcKeSxjn6Ccp9vRXE9U6-kZZxMIoSB6VRkkuC6N4cDxKONLQPIWYjPmVCuv5GFtwCG8WQEagG0g1a0IvBmLYxU0sxGtYVurXEsJ7pOtmYkUi0sH7Qz8WoUgbZhTGlGgoiIXiDtErsEb_L2pW0N1tQcB6zfC_Zvapfo0BuSwuLV10fm75PzLDLjdP4ytJ5h6I9MAQvBZmLCHQRIWfZwN8ranYkqzqif6n3EwhBNDAyLouNp86lLfvp6AFnwKVSBMTc9XqXsRgn7f5mQ63RkA-uOVwhh0D_8KP9dAHqfPITT6b216cDgl0P1MnoA9hlWdtQK-ouIPOYdOGTV34bIho-ZZwU0YjzokVbawAsK0R_9woa_mOtlugvz8w_T9oH31N0Rgor3SOzqKxwMW7LWR_72v4ItGAZfEP46razC8XFAF7jKjRqFx5ejVqfoCpZaX0dffY2H6-exVK1BSf2tLRInNeNw5UI5XnJ7ntDTPoqxQTJDxuH6Dh2y0aCApbbgVMlkd_1j_zb5hTCvE_ucXTGwbsRaFIQcWphlcjB3kmZs-Zy2d0mrKxEHbJrzn7CHYQITEdj5L9iWZ5V5Y0iDAW1v4hXTlnr-SQGii0pAd_zObQvDu6ghV21TEjKMWAinNYCCPe_b6LquGUDfzhOWjXwoHXchhIRCRNG3O4A5CedBNeLdFz6zezOAoydgpxEJ8VQ1-DJI10cVYH8O_OSYhUwzPyY98gDcMUsRoTt6SJliW42fIZySlw8Vb9zR9TLXYABfAP54T5sq-s6rnkK9uB3znd-WfsCiomK7b5n63faK0wk7RS2pKIwrly_PBaeT11uaKolSnAZQ8sy1z1p4hLPYOQ3lQ-0n5OIkuY87SbhjpGg_GDHti8Hm-qAvMYrA1qh2Vp71TSH3DEvGVk6ZBcN_R9TI5mReOWQ8PDLOcPFWzYrNn9yiav7CCs0L9-VGMSqum7J3Irp2jcKC5WWVXcdhh7SQFTCOJ_4PBsetgK2X8FnfkG8IPJWxoTBTrI4jm1BQ5I0smEmf6v3wWfCOZGrcz4xi1k8LuPrAOFo1Oz8DH6o0W_Vg8fLAPr7U5bD9_NEr9zcKnr7GUb3cp4q1f5OPJswboucE2CpsE5iBh0LisbyuZZ9gy91zVDSSZ6E5WpEC6BnfAb5tmVHBPTydhGxJB3KRVAsk12unRtC12NNR6NF1EYKXha6yax_us2yqVPCkJ_Dys4p8XYn1Bytp8hybZS1fdPN1EiUM9E-nTjKRg46aHiPQdMJ87vV7dAOcyuT6KcwPRW-V6f0Lh6qG6X8NaOWMOrZnbcpGiY3HZtRO2qEq5G643c9F7PnErVcv4F-rp0s0MBeTw5BuTAKFPlD2NMXQVep7MHMWWS8prbonH9b3sJrcZiMvjybH9ub0wJ5bZmSAbhESvkYBTgp4GKvnXC8JVZmY3qw4c_IBGxMeNY7WuYfGpYrKpqrcrcmb8Lp9IFlNMhuNUrk7-dsctEtx1GULxz1c6HuLFT5atoi_AvfHgzLk6Loxf0vYaWKoPMCoKU-ZfJmk9sBsEukRyPOHuhMwMZ3nYadYCcE_ocd_lcqh5KVSonYDXS9RlUfWSZLwLmdkWgZs_pgMhaNOdvYjVyYSHqG6k_HO3RYr5C7LsmfQYtmmyIVryYCMIUU88EBjXMSa6RK2fCD-IWDJuKLYZ1XiiFE8oD73pw8aBVtn5HTKNQPMwiMomqYoP1K2tB5YLgcX4f1NLJblF9Q0IdtXq66X_XLbQ4l0OYUMGJ-F61sSMC89KP3S9yTD4Hs84EkW2299BDURYIOsAp-oX7HtvlQL4STx1AVqC_0nZH_T9qZ2wSlcKirHugWJbVizFN-s6VOa_mAcVOsclzO8ekycLmd_k6xOEGiK1VadT7iNPFTJx_8NQ1rPpBSTvNZpgLCckx28X_yxbIz9vbPZ7HxIqhKv6aAiygIRtO22LTNJeKIqMgeEHfLUEWyync7lD76ScqXIHUG3rv6poT02fSPAfZoxUbArvNnet35_SK249YHaC0KxJUt-BxdDbcFU1M1hX-RoqWqcGKukVSA8877y6Cf73hSrH3S2270TjatFi4A_HHpuDXD_VX0Bp6HXcKsOlfLwKe3uI_g-ARBkrEevKktGbQq1Fzon6WwRW_Sp5VhoO28P_EwLmawGgHO9AJsLv4sY8xjGZ1Bn8tQsirU1lkqnzoclpzOL83ndc185uKjyD7PnlSke3iW0mlUTyy9LfkJGyt_Sl6UhO4hn5_J2HBNHbWKcfsvNCEpT78bJOC4phaJsURFHm59pmP6SvtDAKVOnRu9MjORiVTmCgepEfVyEWgTcNbxjuquj5y5zol1VdJz8CUI14OIzTTlz9Yp8pYWOrnUIsFmfGtGDmzQNxtnYwvcncJ58_7sej3AXlrsx5jhLBL017SlYriap8FFGcZ4ruPOmNKCM_H1-tG-my1l7pWkQkBU6zvQQ8-RrsY2o3Yav6raJd7jSDPohe0UE5O215kyItwUYoeIAEAXzdx8tXgfyIQIRY4fO8yE8LMdtpn3BQ0cfBiDw0vU6WyILKpn3WevhzSwnnevDeRTDTAustw4pgld8vu9Dze9MYQXIN2qyDBGoVIwTF95BDd1R6mnXkRqicPwpzS9wxbag66Rl9EB0KcMBYqgDE1O_sIquQ6NERFWjnrpf7OhuFPO-N9kbacBMzBuyBjwCauL0PxO6THKfOERQKoZwzOsH91ujHrmaVp1rrllDPXMGlqSia8RHcjROlGf8-VRJEGBvLVCfS7GvpbmZ93gLF32PEGA9P0wOE-ewUxIEtz4PyO0zBMy7XxQmelvs_5GyYVRbPnXwLc0PCMyZm7ILQjQW2hBiTiQ6NitxlP6m2hH4JWKiDlcuKljnHBYo_VvvezSA2K_mWfVwNWibxPRL765FkoOZ1vy-3uBAJ13iFUkOVtWgzO7VkPp5KLNFPK3TSaF1PPT9VwSN0hrHy51eDfpTJf3g8SamV3HnbP6rCchnBQ-oREiFHklaeT188XsOjC_HO4cchNQNSxJZLV0ALhTi17ATamkbRcoeVAOiyJ69Utk5mnF-NDbiergvig8aHctK69J_X-D7kapkP4L29vzZYmgk_EHhFpsBcsQRrGw1of_EwrlmH-zvWksvWy6uioagZYQvZDg0H8pdV5pphQq_Bfg88DQRE7c0NObE12RvwA_4sUl1tvd8yJZjS2shVZgsWvLQaE8KoCh0yq8QGfwAec5JZAVwNrW_fbYQ1S6VDyiRTO791TDV7JZSgDdnRU7Ul76bN49-tkfM9bdSnQfoxWvU1_ExvWp6JC-w3D59Yy6LetxugKT5UO7NuGciVIxnaMZyqe9RUgwIiM_GyHiwR77ytampvqX8P09hUQRGNP9O444ksBJxlFQu1wpRMZ4E0qdZIf8e8UyDYY8IWITP9qaFu9OX3_7VQzhd33SYkDb6bboScY4dZ3aj6Xjdc-96OGzxo5eGbhCG4p7zGnxNmNdzvmqdNkIYOhx-0nvI62tY2LHr3bhyN5oEoRQTwDYeaT5rh8ByQV-2EQbWSxSpydiiw1r4hm7hE1ZcOnc2JsuqP4IMZtFSDJNixIeYjZ16pPDcSDJDfy1SyLt03UnYxffnLPQh9xw3WWoqBTq05xB29An0Bohvky4mReaMcfh36ko1QBMFtWJKruZXN0J40CAvg7rnmgL3eW1Asf4tdXgUS7gVTYF3Nyi1kGdRDaYL1zmt5DOjxPrnkJAIWNDwLYI8cXpphD7IAtL_iLzhsU7Dmp5QAfgyerz7LN_Z7dBniX26mmTYvPOEZBe9hOOmaRwsYbWtyUHDgPvJvBzqstVyEnhFLggkRFIKdP0lq2c1G9k7X9xyrRgavReJs1JkBv_73DG-VNDmcJiV9M2aoS-nilhNSZ-kr5CJcTM9Usss1q4U-Ypu1c4X3EIe22t3ErgHJKFZvzMjw1rWtf50uaGyKwNulmxf3GNhOTbeQ8cGt6Qzr8rcfIPJMuNPcO-a8_dC7mtDcKu90m7wVIS_cF1oE6xGa0RfzXo08WMOmHjPsJWfuxWfu5hSFKn4wLt348DoImm-ni1o7k3oh7ZM_mFfZ2C3ENhnGnx96ZogCkV21Rktn4_3o4oD9isNhON9dtAMu_bMW7dEEe3q27_lmBgeXlOtw6w3v8mi-XrFZkXRNsQDEPIcNuYQ_eI2vpZjjJfaGIthFNwXqxBBijWPM2xkLI_QpFMRKDB4vbHkyZnKAB2oQgMXyBuWPbq8xicvaBQqFAmOndP9f2VKyIdgK_FmOmUWasMhrkDv3qxn5Yo8WbsNa__6uKMXUNYL8ZPwjl3f3d4j9HxAzLWVS4Kn8IawkoQ3QsJ0zWiNEj6QAcdzNTPOTjrdOBwCi6Mu-BM2dFGWclO8e0oltbf3k3PIrteWeUFtp0txV0SbH2sCFiE4zWuy5vg1F_ApVYMx44x47xUkBLXMfUwiJe3rZ61uyVsm_SsDVYtrB-LJkRUR6sfvDtv_0vJ2_64TkRZgWz6PiqYe0X6ivJHeOAEcpw7kjf2ps74-CSN1BGWF_pN-UJcyAZdD34qnN97SCUGIBYVf5ccDGeEURc2IckKhyjJjWCMTSrXakxPGJYb3qP8ChvfVgGZJ0KU-uhSbcoEdYzNBxj_AFMzjddJ-0X9Ck8Hnd4zD0KAdogYhYlpK9vuOanfdy5bJRy4ysT8Y875uXzyp-XcgUHQKRgu8U6BZbbOVDU-DfnXItwjiHZYcquwuI_zRMMRsdo4P413limJxxLj5XeyP_W0JIJyDypwnNrgjIgHxCIaLGZTFfWyUUgG1vwWq6UCjeZcYkibbJ-p6m2_ZLZpPJqEsCniXyJi0g_L5AQ1wpx9xqJVULGL1Es0xEuMcqVnauKE9JyruqyKt11RKDacx1ZauSUSZfHsAAtBrTzV8pc2DIdLPYgGEsFPaLNQk-48RZPzz5RUd-yDzonKMM7OS32XcKfzQiSaLcI6d-7iI26Rg6KCPYL8q8C0eH8PGiDP6tMiAlq9Db2QL14tgVLrcsPn60l4qJ95UCdcdRy8M9yA9RBvUHomUtc2X4oiBDio2Nxx_uKDLz_LJtDuVl2Y34gL03BaSd81Mq4hqyS7np6e-E_aVdOyJdq9J2PTcgyZUxnGbst_hzplZe8mn_a9CqBxPYPC7VQiNonjNHqHxffyAvwyeZ80TKLi_yNHtxFHk9Ckqmz0vvAOzEljMShf9MVWM6eqXQKrqSR5u3Eg9J3nXnKR_6gZAtI7wjkHtUdNEN7Zho0cskEBtMvHxfBOC5n35C6jYwKG2YLytsAEmyWbRECQExw_05FZUFi5d1U823Bfq0MP4dXNoACAYWQXkpX00YOa74VXOAsTIBJhJ8j6k7cm5jLwxwfZqh7HWjIAGR1HFCZda5vtcyc5vleEhLHmoI7yhB7JzPh8NpgPNnC9EAAJUPJvLoGzrUy5EesvKaAdYNzJVBI3uZ_2AYhQZuJjkLy5dA-QOEMcANcveis7odWk5lqNq0wa5smEEf9Qd6OZUmJbBTkTrATlPs2zKbypJyXvPHM2_sqt9ylJMRU1u33m6W9TA3MqsZlMn0urO65BmMiu5RQDV9LkCmHLgOs9xa5p6R6Q2urPQPGGxpiYZywQTKciuWUlA2NHvaYf7DDJPiP1iQu3LjBbYen59b7hFyPPixl61Gh86b2Pvi125Jp-AHMmdvr-H5fp9ljfqXlCgCoBHpwWTxDG0Hqs1kg5WES7KRHssgLVKsy3LkktEm8yMFEa81E_8dHjMgXkselrSntNYCjThnrYUdTMAndseL1y7iCLFzPbvUbQ7ITvVry2CQZxqg5jkL570QNRPoydBOibihwIn-UyNbFaHQYB6fVAIY5Wh4zFHG7Gtp0-TemkoslIX_KUMFC8Fo3oBBISeWMeaqMBcNOcYzMLZ0UJZsYXljed-nKNiHQo6RPM1av4G7aYxLoIjr2zs33hUHGd4uzACNQ-TNBQ-EZZe2hqquTtoE5hb1mepZg9d-27-T6_v_k6k__qfwdUVrz-C1p5CPohMdF0sr5L4Vue2ojuA9VPqPc-sSkA24nZBiXpvwDQq0I0fJG1t3tD8DS8KhdBRXyaoWkHsr7dbAkiuOty8qfKT54xDfz21WjscYwxDDeGlS11gRnhTZSeL-cpS9Ff4XvZNS0C3Jonv0a0ifCD9M-70vwL-I5LIjt2uYE44ddTvtrBZ2F_DoFJ1jNLjDU4d5GhV829dBIRUEFmOT67BkzwXIun3MhIXTC-RxEZlEVB_5-IP3v9YvZgwPDHotGrbfxVlqS-82Fz3ejvMnSRpF7OAbziD4DHLMF7Vb6Cwj6uyoH9oUmiAZ509JXV2Nk4IkwZChjgS4rmnOE2gIlWyIuJkzALdoLGusEjUamoXU1gN71X8Q5bdI9Gii3QUzKM1L0SYrRlhs-JMH_u6kMD8u9bWm5ZaFmFfUAWHgy4vpdOInvtCWeGYD7qfHAgWFUO5_2_6frC1xk66WIYLFbiLKuvhYZBGe-g9K3iWgsLxXrFfs0UgmyJ_Bh0drFmZQ06LPusQgebaWPXXdotr4SZGEdEDcZ7ZZzEFdtWIddTI93_f8tHUGJs75J6AqqhhfHVimoNC8hyqnVuDaomeqy7-mzcmqbeLisysCmwfk3nE7WIwe7nEgcow-B1fLsKbjOlMntITPw5roIj_G5uW1L_5rpWD5SaXNmOt9IKPQyjSu_qOdyblbjjJQ-IrGIhkbQp27ZulD_RqKHIBsEfu0-YYvkBPmw7Ws-3W4BuJCH6V344yltnRszqlBN6iZQKF1H-hE70RJM6omIXpivEO9CyfAaCnszdsfPr9zIYaVbzhl2QHRvPOqyXhawvIyt1I0LPEdDTXgoD7NBRQCkeSj7UqFiZnbE_8ZcJodcNx-KdI-dGklIRom3Ml_-1lWosoIGUt4EkzT8kFP6lWivab975lq0OU8Oj3tIHMjS4rHPfNgA2eryjQ5pMnIfE6lXglE4X39icS-yOW1oJWbAfDrWa93KNpnQ2CrUVGaJ3z_wqGkmzouPzIDOu2pXARcJnP2yPzFt-A6T59GlZ8AMWtZY3Oenam5tKhJn_rmzUgDlGR8kdsPp4RusyE6y3EldfUKZNOB9k4s2Hv5g9p4mRu2FuQ3GnT83MfPvem72N2e4h40iURtw-3Q8xwi9yK_YeK0u5CMydMgyKBmY6Ecd5kVJ-Inihc0ZeyuW2Rtfh4zBUepsVIObfdIAosUbjaC5Y29G6RvxW1WYRTHNPuo65XfQCDIT6_ocSa8naKPQ07FAofihafCj6OgkPQelxxNiLsQmONDrtO5e3yV_SbEk_h3vQ1O0tjgwdiP4FWW7kPcaAaCy6s26YTW8HrgXnB3Q3JG0qw4rdhbR2UyY9854IVkVv8FVGIK0eMljBt1pWLN-6G5UM_9PSJpfbntutPvAacVVSgUCe-Fn2r3JQylza_iRDXvcwNQqnOdjqjijQpKSCkWFvxyyJsft5WxtBc5y8IuLMNM4nqIO-jwvf0mnz4jnqTuzVmBKpyfLz8la3_Yp2KaovNIcSG6y2WwYint0K6IPNRW-H2PPnp49lHkt4rvezHGsuyef_aP7PX-1c4HeQz1Wd1SeFfZe1IuLKBvdKS3B9CqxsbMO6Y6pDmVPWohq825JaDGSbUox393oL9NBJdQMGB0ZmTuUsWpvtHrfp2OxQ-1IFQapQr8DtoOtrwF0urAA7en5bWey5pAnV0OGbyOpEgZ2RNa_QaH6qk713zaDOzje5cgk4suO1dDRBDLf2MpJRtBTQN1zx4mz1ILcvw0AC4TlA-PrRq2NUGZeqbOeFO5lkwXYyp6oWwSuKt0InGHR0vyIGUHx6FBoutBaJHlPecLOBnvcqn928CvAgwewVt3Qz2BoNGN1dTdC_Rh3H6yeb7mAw8rrOhbnUQrthetHL6kev2dw-Ucil9np66fI6UuXJWZ6N7ARdgOuNSS7GUAkLNaeBYV_D3e8plMAJUBAfCe_nGl75GskPMIlWnIkSIsXJq9iTJHI_5HcFX04ga6e6Hyhy0Uxojl_0Kd6UBRYDrOT62P9OJEj3omc6xbBm0uvM1ZswfqeIzbH1sld3PEM9G3PCwbRvGWezVjQWo0_r-f8UD6Be6ChE36-FgFdAiQIWkWVlrO510O0G8OWoicDXO0bfNMjKKk4yf3xBoPMwOAZAYRNvyKo0OKdd6SXswBRtAoQYj3PYY7RPTaagX5X68zLGG7qt7zUoBzHhZ4HCa-iNvUhk-RTP2T4-w-0fPGh0duyEeEYdklTWE3P_f6UKAYhQ40dYhY8cJ9IPHKc0prJoWpgj3xQB3R2gvd_jK2lZj9ZqIhuZZS1EcNYZStw3wZy9Cg1LC86Le8Xitx_MtLwB0nmbpOUOucjtBEO0_p4DLAEXAYeZo45vRh2Ayja1vX2LZYq_JSlMmggLRaOrIjiTPFamqOcrbinbzVJ4lPKTHISk6JrDsTXTOKrPtDORIbTKcwD7W4lcjZA2B6rf6c7__Nzjx-3lzjqX6BCC3m5fBzuEeyJDx0_TIA8dXDEha28otseMR2x6mouVkwI5zKpbt45KjuHWNbD8xMDYg59txuvDYN6ncnVUFkOQ9WUz1gtmVJWexA6kAJKDNB_LD0-jkzb-8SYN3RnF1QqBR6GJEbIR2M_UjED0GxT91iT3QBt6vdZ25ro71pM06wRVdNMHYnZXFbVn-bM1HTw8Rc7DMB3owQESUQm0E6UodamHZADFvG7f0mdpbDTKZF7XPsHMWR7zTXzT3DHx73TLnGbC6kHTdzQ6QiDF36hx9IacYnzqTHiXS4S5eY7ANa6OJGab0I0uwbGysMHt0gGPxdV5Ce5ASAY6HjarioU0Jg_dqYLgAwWMHyxkOwojWBlV3EHHMenc0vRCvggTolqBfq4erzxCFmtVZ7ynbOdT2KAHUNu0qt-UuIXM6IJ-8O2kIQlKvVENHjYBVBzceBd02657DjqglP0cjmETjbHWNWXNg-z32uGxAKnunB7_ai-fSNwakDyFzyPIi-vT69CJOI9UIY2yyWTtNyNCiUUSAgSxezbXy77Af3gEK_PjSoXHyrRAtEPv4cykr2_tZ7qgqQ8E1eBsizz2mImxChVp6-X4GRhzfA5hxu1IU2BbXIzRoa8YwViK33oaLqvITpEnGjxFgx8hWHaBHNWvBzQBlE3LoZu91JZ8jz6XvVdDbUj4mo96fqYTFXdGvt-iSKKaCmbbBcVSrk8uxxvauBNfXlYYdhyZwKlzakaFFd05rqag8M3VG1q-upFoiPBtrgcMqT31NkprTjw3YDaXe9OiNRlUNT64cVzwlkhxU4tabkuN6F3PXvFTzoDjICei4Vd9Uwab1_yAK14OKOwk8GWjmk_BSqEJCwyeAAnbhjhkg7VfmO3YAN45Tg09SvVF7E24HmVoEakK1MqfXKl54LFmedpkaZw3jcp7yMtFLhNfB0iupSJVTF7zK4k4NvmiDVKBXa_vNCO4SFcpLzOeuw6yvH3WpBH2C6J3kd-7izeZsDcZBNOZak__HXwk2Vq8kpOd1SalueXHJhe9knJbTDyi7KRpZOya6CnHU5vxxTkGhYCVWYDFr5lNWp_teNUky8rThkTBNjTIX2RpWnaLUFuQ10NolmR4wd1cn_GbqMGqbPeUlxguIHceNM1nh4ND8vJafK3fFNIZsg2tW_lZmx7QkIRC1b48gQkQPwksNsqnMxOvfELo631bqq-i-HqZush7V3qpyITXPVwghp8kERqVdBzfJseVuZajlvsZ1ManurZ9XHV5fbXTHMiQVXnWx7vuPG0rOy1DLs_fMoWQfPirks1gOT-05jPTmaAOd7NmUFmqSWr6SoQh1cuWr6G2TmNYCq4oB7rEnwHL9TlPyzFHM9MnLw5Vtxjy-7Js4fbrhHr0dbKsmqQSgh_eU6CT6tBlMlOaPcblYixG8TT_ko5b3QSi2Ewn6-Db-j16YevOeeVTU9MEmJCOauluSoOF5okXiT-65Q2aR_01IU7fObvwMHJUBeJcdxLZDKX4aYz-HIA4xRKYayxfi1Ix0muMfNiMtnXWLuKM-EPNJybrNnykUsiF_noX_L5KZ9Ha0qHlP2k0yjGLHj_QA0tH69iX5xe4M8hH7Ko8dN4lTbYLhtssnH4U8_UTtksPI16gIynl8I3W21WlzGWB47LWLrEn18PRl3Y4VtyYvmyRBvqHfeeAFuDoqVjoGaBozucdJHomjbGP5s7UFFJ3MiWruxpo2IkTcvz1PjeshujRHPsZ8bwVaPzrvyelyx-dm5STSf94gSlZskePSBE_P0lV1v2qLyQljfAWTHMb5cQ8V1JJnN7K1vlSJfhDESoM2saj35WS7SJCsaDXJx-yuaFeDqGT_nN8L3Kpjr1QGbUxq3D8p8Zoxj5b92ksQ8CjS33YnvSRQLUFNuAHXiYRbvA1f8gkEJHdxuo5srsP3fh4FEnRL0uzw-LtimG6W5P1wTYx7inWclFfwzRR_QFnMwESLrTwbpA-K6iUX9NJZWiqUny_geFdLfjsd8ys6m4-A9-8ryhYyguZY0hHKPkjKbecfNZy9vLhLtMUx_gzgfMUn9lERbS7TMGPbTrHW694IPIpF1H24tPU9d-FzECPklTbonYIrhx8sJ7hiifb_diUGyZv0lJM7ue9U2VQzo068joRQGYynfjQR7Y75DHmyDqD8MyOo_zegkucCDbVWCd7wqwnDkw1R0JcHC2x4L1kv1wKrgrkgmcn7cf17xu2RiP8CtY0eTo_CuZBphPJgFlicIEKurXG7EwWbPfs_e1hwEwJU7nyuJnlk0s1Z943vpwwc3uE1Wp8aXPbInvCBoaL_MQYKctw2TuGW15IkFKTRoPv2EpxlX9JXSXqKAHF_9bYwGIf4bAmjatuFAjbR__HoREMVwL7YPQO0eCOemK7E0bxcZQu-RE3UNwM7tllKPGRlu5t1N0xzZKUjxjM--TNtaSrw1th_of4ImyDD3HUJ7VrrIq3DJir0HtaRQuIYToMLloMvlewlvffue3Ca5GE-jEUhLMrWPghvPFzo8caZdLSlf0LbtaCWQWGtGIq9BeEm7q_bPCbiaiwkfWJgJkgAJIfTGefrA04xCm88NPKSxkuSEMHkcRfGtjyPX2xjKBZosPzYAcfh4uU96_euUz0sm1K7hkx56eLqnPiUpLjIiPrJBCqxpIHvCIEFWeQS313L1F3Noc9dGjsdUbgTQS-__eIvPVR1JJXfb35NM3p-43wEFSO9kKm7SFAev8DnmDCP36PAP8grCW9vHJG4xE3QbXzH3qWegmuZpodQ8LAFavgz_QvFGvPT2Cw-nkEcLoZv8TZZ2EwZlWBFon8TdxbZI-Ic_QtmRcjXyFhhSm1j3HxZAfWAFS2iK0JICX5V-W8eEqH8x45PALWn2RuGV1_JtN0KrXCFTp3RYsgGlRRuDD7vfE5HnE4UTGweKJjdsdgbtg6HsM85yDHdPlBXw-FBVYwqVTCEyJEcY9_vcKFVwP_ngR2A9IQqg6iNW8P-oCg2PWI23FJYpaisDqi7iiiOKP-1u_QHVA_gOEvY6TrJieJ2OGZooq9aAQ2IFweVd84loz95LsC1-WO1NAniZOIq0mPLjAgkpFAb4S9NLbtoAGgpDw7gjlrBAk98UMdSmK9ocBJJMLTt6wlBb7tjr8v5T6b0S8lTqdztz9laSVcwC2KajOIbYmCQEGOi5xgd1__BV06uSO5O0Pr9S0A04kFiVRTjL27ZuRQ3d91i6j_WTJu_c-dOU8bIZuPRSB6fKzYgPKIdUHmk28Ly8yK_DPgs6PknSTCSxhIRCdtBHIEBV6hF-OLy76rVaat-PthSJGLbjSguClbBhoh2_kvU4euTGLShTweIeNG9mw_RzrbRXf6mh8Q-hhDyC_kt-Zdv_kD6qnziCtJj8W6OLn-kUzxe3lqsON8M5qaHkTntSryC4rgjAU5TSXrke-zmX2qWXltpxpCzA4hmzV1cj9Yd9xbJQZ3cgZOTOwerhx2QpGl-ZYUS_bcIQUPeOfDKSFop2Rv7qR_FGOmR2rrbehrL5nVtYoymfqAFaEXUPqe2NuTczOuPxQz9CUBY41ar8uAWvVknGFaaM_H_PxBaZ7ushrBCfxWJ0tbiE2o8MaHzPU4icbbkY5a1LochxrD7zA2YQGIco1He468jSRe03N4r0Pq7yvosirqbjN4lN5hsyIGDEsWWoPZiOtC9xy7RR-HbepHE5lJBNia3sw8jeMAcdysofmLbQxN1N-IVg9Q0WQwxZFNvRT9H_Bvk4TJci4unX736J3VB32Unf3J2slNYMUU4Kl7H139bq9DX-xtq0lz5tPdkUGJJ-jglPr0r5euy7wRZs0FzzN_MTF8G3p5OHUqxtA2MAddUsAJXS4Ycz00NrSMtGjD-Rd337sK59loR0y371aL01WqKiQAvwDHQL2BLOQNQDSmWryiuuk7k5YQnBbk6Fn_r3pfebs8rmxLDo1iCoZ0kcO7FbQEZJWd1pmo7w7K0KYQ1mj1KncvPoT6lySV6ykAQnsjwwOBh8M-BDVjKrFc7Rp-3QKDj0aShJkfLPe0bimhKUse9470pIruKHcRZ5EHEhcK6hwA4II22BwpGwgqLyFLM8uIrl7m06A5zwHdLG-9IputZdumTB4OLNbpcBY4l76g5XjRTjhYS8KFmJdcwf0MBbee75zxk9l6oxom4A-zKK6J0JBAvI5pHC4tBKvD9V0IfMusYZt0m-FwXDY85Ajnx-iwmaNAMrO3WLeM3De0QSvQUZxc2Uzqx_5k9RJBqvUfgOpzbQ_cIL3V-S7tFEx7X7rNCgKB6DzV9blKMTDDOeaJHkGP0RliKaOwVt2s_9g0pW5LNXcXxX-_qSYzM70rYtXimPHYKm_TTK9eh3qW4qk2x_IqmmLYPsVecPZ8rM3okBSLliX9a-efRIGjZhisqAxHbsvSyYGJA10eTFRXGchbNonEnImeeNqVsgUQB8nPfUNYv_SvzsiBKvs_tht4QBV2XI8XNVR5CrgoA8Ndl9KyyCvblnmcEXh7QCXXyvX5DbNsnx8KQdW06tS21qlevAZR6cnmpjtpzRVwfMex1kdvhfnoLQv8OvJ7gCJVg6hCm1v5LdeCKKYKqNHA_UcqI6Ox_db78xYvE3IfTGQ0PSuDgFb4s17I-f9nRmh_Otv0dxpC6r5vtIrok1OBiFjGdGdMpqcB5buNcPDiI1bbBjMNo3PXvEYUQz1i-vTHnyrI8DeuVt5XBgGEIO7dFxk1Gw7qHzzxiwZ33Cc_rDJ_z-l-jkv8EZI7z1YDB8zHwzi33kDdSJsicdA92tqI0L4G7YiPB_6k5dUJKU6pxQ8GEReIcF16WOWeAtRBaiPmEGSdlvrfN9UjJrBX8HTEyHsF06QoCJWMXEmLmrVyZxE6YNvFJ9gvFhAGxphy95nFzvx9gdTTVXsgP3Ogy1Mtz-tMXao4bH22E0qlzj57Iolr5p0JINS1Q-aEuEKKFh8X0ba_2onRvkXLJ43Ew-MPeGhvLpa-ZANOErJKlI0a3kglHedj6F1ej519ulsRjQQVb9Qu6lZHywIV067NqBc2LqANWu3_V7VrVQJT_lh58fw7WcUAxh52NUKBCaaFB1j4ljE7AnOb-fRCS55SNKyn8Ug2TiADw_Roya_7xfkioKWbBTFJgF2maqFUwp85DzrmEE21N8CpSJKEEoG2SPKw5NkpLNL81niNv11R-BF0ptQ7yYJNv4zwmc-2yzGT5s_DwXEvvTA6-rzUn6-pVMjqraND5syl_bRWC-2X0bCKSwq7bKii7HuznebUa3UQyO1B1ozhlUOVHJy1Sj6lQHhUXB7dqJDgjPgtPJ6r_Y7XSAzKQwcSd3cE1FDsfDepWO4XW5qiMsFIJR1PQEeTqWjOc7WJdDaSIeMsfLzCmMld4i_sBpMBIC9gRGkWLxKvLV9LoefX44z4fYnCB-ZiSF75Xr_i37YIQPCo_HqFOoFy6BkdIGd2tVyu0TYbDSN47ksfMOZVpy2cPPdcQxI-6vEmVZehSDDotc9Rk0-ZOv1jMQCyVIlTyIrXFGfNXiGMMQxn87jKANmjFMKhNoKe2QiwGlLmxTN5X67f9-KO8ki2zfXmJI6BByGIb0TK_aRgpAN8myJ4SA9Z1cQYeJpiQXZO25p7tCv72xxDQ-qv_YClGDrFg5nANYj7ViZhlS1ocB74wxnfLMsS0ZNKxME7Zqpkekgl5BCt0M2VpLdPJY43mzStj2VbsEgVa4kHkr2Q3jrj6a55WUBb8QSDTDH7uVNcFbzRMsU4NraqKjnpdowKmYi4BD7wkwN3Mf9mzQKyKz4rT6JNNYJJnpyIVjwNW4Q0VCDfxgyxLkh9MAqhaWIihuxZTwVhFss09SU9UItCOxPXgNiIkkvRcGT7s9saOwckIdSuu5Z9y4Hjc1yFq2LaqqD6btsfDrwR3wyUnKDLh7AjB304zLIvt8Eu-GEPLAiRN1eVpWmQ5ckS0u2srLPAnpQkE19a3ddBHaIp888lg4uwj_ZimVfhCuEUWMU2vmdkzwxB3E_p9a2-hkkNsuSkdEeb855HCF7R1hTjkFGOPncRjOEppYTcfFMD2Bvj73MhOPGeHXSd_w1O32l_WchiG3StiBeum4QB284XHn0f3T6b-hAvxrX4GuGBCsRxvOUqmk1fPcumFB3O0DlpFfKnCe59k04pFcTI7Jq-7GuLk5QhQ-PA5z8gYdTFFoJ9oMfNiXgushnyoXCY1qLoHYHjmrMf37rRg8J3xboWKa3faLh8fSTUKIdsy2Z0Z0EKi5nsNOzCoCBXEZUAHzA0oTniu2ZbrwGWZJBjYB3i8PXMWS1kGJ0RjOaMMBoLg8j2ZQV-dGKwe6f1glbcJaL3LIJ6D3mB9p5gAdPKJ085wMdfrsN-NARti0DbSu3l5IQCcejwSpjD8F8h8CpDZHK4wuPLWT5yJjSMEAlisoLm3uZVJTy3b5sTgUdDtGkPXbWO9cH5MscvyO-BqzHe2RIfhDGeMc_XezrO1Prtl9-7P6_5IdR9BlYF1Y4WYorkpKU__67KnNLXIzimj7-r7a4btRi3TCM-15e1dc-RdvczI_sQWZq6PlWcdc9TjkYOxZw2KHqZiegFPFXf6RK5T9MzC4xxUq75eaVosnoL9N7wDxC-Ky5GWAvMMtJgvTX8CeMmvNGZN0fAYvtOG4X2_4pODmbJPOwKkGNv1UMiSgQBLRYtS6FKPSrA19cgqj3UmrzIRDgotLCkTn8aR-fqB5LIRbwqQ_MfxKu0CXmHCqBdjN26RjSPNMpSLWngmMTW5LVYRjKqNNRUavRgY8WxQ3Zu6lZO1LgMnKre-zS7hYAgJy2WAIwQ_Hx1c4YqkZTXNEuC0QaX4uY3jNq7M31pgTZj9_EoI7qnOYtPmdRY9RxMJWFHP095IJnsSUNpBYx4mZO6PlzF_3u1e4KaVQp3qTWxY7O88efVE1tO6Mqfs6aD9nyzIOCpgdsOlnMEm2rvVdcQbnXhIj_D3O7FnoieYzcfvBE1lruM3l_I426WvTlaFGMyhf501ABi7CKjRz-wfJHLTY7bkImmODRZTm9ewQTuFCL0jmlPx5sfXRe3MVLYRYDo264DvEFWx06HZxU4nXnmwJfDcNskYXffgKYPA6frrqCXeOWygJxX3lx69t95FGLYjZw=",
    "summary": [],
    "content": []
  },
  {
    "type": "message",
    "id": "msg_067cbc1b188a8a7e006afc008198448196ad3bf161c08bdf81",
    "agent_reference": {
      "type": "agent_reference",
      "name": "k8s-incident-investigator",
      "version": "7"
    },
    "response_id": "resp_067cbc1b188a8a7e006afc0078407c8196825c976de2705bd8",
    "role": "assistant",
    "content": [
      {
        "type": "output_text",
        "text": "Root Cause:\n- No CRITICAL or HIGH findings were reported by the provided automated scans (Trivy and SAST arrays are empty). The main residual risk arises from incomplete visibility: the SBOM excerpt contains multiple third‑party components (including security‑sensitive libraries), the SBOM is explicitly truncated, and no high/critical vulnerability detail or full SBOM/CVE correlation results were provided. This lack of complete scan output and truncated SBOM is the primary root cause of uncertainty about production readiness.\n\nEvidence:\n- Executive summary (from provided data):\n  - Trivy (container vuln) results: [] (empty — no HIGH/CRITICAL items listed).\n  - SAST results: [] (empty — no HIGH/CRITICAL items listed).\n  - SBOM excerpt (truncated): includes many packages such as jackson-core 3.1.7, jackson-databind 3.1.7, busybox 1.37.0-r31, libcrypto3 3.5.9-r0, gnutls 3.8.13-r0, gnupg 2.4.9-r1, alpine packages, commons-logging 1.3.6, etc. (truncation explicitly noted).\n- CRITICAL vulnerabilities:\n  - None reported in the provided Trivy output (empty array). No CRITICAL items present in SAST excerpt.\n- HIGH vulnerabilities:\n  - None reported in the provided Trivy output (empty array). No HIGH items present in SAST excerpt.\n- SAST Findings:\n  - Provided SAST list is empty for HIGH/CRITICAL severities — no concrete SAST findings included in the dataset.\n- SBOM Analysis (evidence points):\n  - SBOM contains libraries and system packages that are frequently subject to CVEs (e.g., jackson-databind, libcrypto, gnutls, busybox).\n  - The SBOM is truncated; the excerpt may not include all dependencies nor show vulnerability metadata or fixed versions.\n  - Presence of gnupg/gnupg-utils and certificate bundles indicates cryptographic tooling in the image which increases attack surface if outdated.\n- Note on truncation:\n  - The SBOM excerpt is explicitly truncated; absence of vulnerability listings or version-to-CVE mapping in the provided scan output prevents a definitive vulnerability posture assessment.\n\nImpact:\n- Short-term (release block decision):\n  - Based solely on the provided scan outputs, there are no reported HIGH/CRITICAL findings from Trivy or SAST; therefore no immediate blocking vulnerabilities were flagged by those tools in the supplied data.\n  - However, truncated SBOM and lack of CVE correlation produce residual uncertainty: an undisclosed HIGH/CRITICAL vulnerability could exist in omitted SBOM lines or in lower-severity items that escalate in context (e.g., jackson-databind historically has had high‑severity issues).\n- Operational / security impact if unresolved:\n  - Potential for supply‑chain or library CVEs to be exploited at runtime (remote code execution, crypto weaknesses, deserialization vulnerabilities).\n  - If a high/critical CVE exists in a dependency not reported here, it could lead to data exposure, service compromise, or downstream lateral movement.\n- User impact:\n  - If undisclosed severe vulnerabilities are present and exploited, application availability, integrity, and user data confidentiality could be materially affected.\n\nRecommended Fix:\n(Structured remediation covering the requested areas — prioritized, actionable, non-mutating)\n\n1) Immediate validation (must do before deployment decision)\n   - Obtain the full, non‑truncated SBOM and full Trivy and SAST output (include medium/low results and scanner metadata). Verify scanner rulesets and DB update timestamps to ensure up-to-date vulnerability feeds.\n   - Re-run Trivy and SAST if the scans were run with stale databases or incomplete scope. Ensure scanning covers final production image(s) and build artifacts.\n   - Produce a CVE correlation report mapping every SBOM component/version to known CVEs (include severity and fix/mitigation status).\n\n2) Targeted checks based on SBOM excerpt\n   - Specifically verify jackson-databind and jackson-core 3.1.7 for known vulnerabilities and ensure a fixed version or patch is applied if CVEs exist.\n   - Check crypto libraries (libcrypto3, gnutls) and busybox for known CVEs and apply updates or rebuild with patched base images if needed.\n   - Evaluate need for gnupg and certificate bundles inside image — remove unused tooling to reduce attack surface.\n\n3) Strengthen pipeline/scan coverage\n   - Ensure SBOM generation is complete and included as an artifact for each build. Enable SCA tooling that flags dependency CVEs based on SBOM.\n   - Configure scanners to fail the pipeline on configurable thresholds (e.g., any CRITICAL or >X HIGHs).\n   - Enable signed SBOM and image attestation for provenance.\n\n4) Mitigations & compensating controls\n   - If any high-risk dependency cannot be upgraded before release, introduce runtime mitigations: apply strict network egress rules, enable least-privileged service accounts, and deploy runtime detection (RASP/IDS) where available.\n   - Harden container images: use minimal base image, drop unnecessary packages, enable non-root user, and reduce capabilities.\n\n5) Post-fix verification\n   - After remediation, re-run full scans (Trivy, SAST) and regenerate SBOM. Document the remediation mapping (CVE → action → verification).\n   - Produce an SCA/SBOM attestation artifact and include it in release docs.\n\nDeployment Recommendation (GO / NO-GO with rationale):\n- NO-GO (defer deployment) until the following minimum conditions are met:\n  1. Full, non‑truncated SBOM is produced and reviewed with CVE correlation performed.\n  2. Trivy and SAST scans re-run with up‑to‑date vulnerability databases and their full outputs are reviewed (confirm no CRITICAL/HIGH remain).\n  3. Identified HIGH/CRITICAL CVEs (if any) are remediated or documented with approved compensating controls and accepted residual risk by security stakeholders.\n- Rationale: Although the provided scan excerpts show no HIGH/CRITICAL findings, the SBOM is truncated and there is insufficient evidence that all dependencies and CVEs were checked. Releasing under this uncertainty risks deploying images with undisclosed high‑severity vulnerabilities. The NO‑GO is a precautionary decision to require complete evidence and verification.\n\nPrimary Security Risks (summary):\n- Incomplete visibility (truncated SBOM) leading to undiscovered high‑severity vulnerabilities.\n- Potential vulnerable third‑party libraries in SBOM (e.g., jackson-databind, crypto libs).\n- Image attack surface from included tooling (gnupg, busybox, large alpine packages).\n\nRisk Correlation:\n- Empty Trivy/SAST reports correlated with truncated SBOM increase false‑negative risk; absence of flagged vulnerabilities in scanners does not guarantee absence of exploitable CVEs if SBOM scan or scanner DB was incomplete/outdated.\n\nFinal note:\n- The provided data does not show active HIGH/CRITICAL findings, but the truncated SBOM and lack of complete scan artifacts create unacceptable uncertainty for production deployment. Follow the Recommended Fix steps, then re-evaluate; once you have full SBOM + up‑to‑date scan results showing no unresolved HIGH/CRITICAL items, the deployment can be reconsidered for GO.",
        "annotations": [],
        "logprobs": []
      }
    ],
    "status": "completed"
  }
]
```
</details>

---

## 3. Historical Baseline Execution (Pipeline #3076259725 — Version 7 English)

- **GitLab Pipeline**: [#3076259725](https://gitlab.com/itsme-aarjav/kubesentry/-/pipelines/3076259725)
- **Job ID**: `#18086209361` (`ai_security_review`)
- **Commit SHA**: `9c386b2529f974e3968fd95c2fde192349765a1f`
- **Foundry Agent**: `k8s-incident-investigator` (Version 7)
- **Model**: `gpt-5-mini` on Azure AI Foundry
- **Duration**: **41.0 seconds**
- **Prometheus Pushgateway**: **HTTP 200**

<details>
<summary>Click to expand historical Pipeline #3076259725 raw JSON artifact</summary>

```json
[
  {
    "type": "mcp_list_tools",
    "id": "mcpl_0692ec3cf987cc89006afb8766bc308195808e121a124f6e3d",
    "agent_reference": {
      "type": "agent_reference",
      "name": "k8s-incident-investigator",
      "version": "7"
    },
    "response_id": "resp_0692ec3cf987cc89006afb8766a4d081959ae930969478f280",
    "server_label": "kubernetes-cluster",
    "tools": [
      {
        "name": "events_list",
        "description": "List Kubernetes events (warnings, errors, state changes) for debugging and troubleshooting in the current cluster from all namespaces",
        "input_schema": {
          "type": "object",
          "properties": {
            "namespace": {
              "type": "string",
              "description": "Optional Namespace to retrieve the events from. If not provided, will list events from all namespaces",
              "properties": {},
              "required": []
            }
          },
          "required": []
        },
        "annotations": {}
      },
      {
        "name": "namespaces_list",
        "description": "List all the Kubernetes namespaces in the current cluster",
        "input_schema": {
          "type": "object",
          "properties": {},
          "required": []
        },
        "annotations": {}
      },
      {
        "name": "nodes_log",
        "description": "Get logs from a Kubernetes node (kubelet, kube-proxy, or other system logs). This accesses node logs through the Kubernetes API proxy to the kubelet",
        "input_schema": {
          "type": "object",
          "properties": {
            "name": {
              "type": "string",
              "description": "Name of the node to get logs from",
              "properties": {},
              "required": []
            },
            "query": {
              "type": "string",
              "description": "query specifies services(s) or files from which to return logs (required). Example: \"kubelet\" to fetch kubelet logs, \"/<log-file-name>\" to fetch a specific log file from the node (e.g., \"/var/log/kubelet.log\" or \"/var/log/kube-proxy.log\")",
              "properties": {},
              "required": []
            },
            "tailLines": {
              "type": "integer",
              "description": "Number of lines to retrieve from the end of the logs (Optional, 0 means all logs)",
              "properties": {},
              "default": 100,
              "required": []
            }
          },
          "required": [
            "name",
            "query"
          ]
        },
        "annotations": {}
      },
      {
        "name": "nodes_stats_summary",
        "description": "Get detailed resource usage statistics from a Kubernetes node via the kubelet's Summary API. Provides comprehensive metrics including CPU, memory, filesystem, and network usage at the node, pod, and container levels. On systems with cgroup v2 and kernel 4.20+, also includes PSI (Pressure Stall Information) metrics that show resource pressure for CPU, memory, and I/O. See https://kubernetes.io/docs/reference/instrumentation/understand-psi-metrics/ for details on PSI metrics",
        "input_schema": {
          "type": "object",
          "properties": {
            "name": {
              "type": "string",
              "description": "Name of the node to get stats from",
              "properties": {},
              "required": []
            }
          },
          "required": [
            "name"
          ]
        },
        "annotations": {}
      },
      {
        "name": "nodes_top",
        "description": "List the resource consumption (CPU and memory) as recorded by the Kubernetes Metrics Server for the specified Kubernetes Nodes or all nodes in the cluster",
        "input_schema": {
          "type": "object",
          "properties": {
            "label_selector": {
              "type": "string",
              "description": "Kubernetes label selector (e.g. 'node-role.kubernetes.io/worker=') to filter nodes by label (Optional, only applicable when name is not provided)",
              "properties": {},
              "required": []
            },
            "name": {
              "type": "string",
              "description": "Name of the Node to get the resource consumption from (Optional, all Nodes if not provided)",
              "properties": {},
              "required": []
            }
          },
          "required": []
        },
        "annotations": {}
      },
      {
        "name": "pods_get",
        "description": "Get a Kubernetes Pod in the current or provided namespace with the provided name",
        "input_schema": {
          "type": "object",
          "properties": {
            "name": {
              "type": "string",
              "description": "Name of the Pod",
              "properties": {},
              "required": []
            },
            "namespace": {
              "type": "string",
              "description": "Namespace to get the Pod from",
              "properties": {},
              "required": []
            }
          },
          "required": [
            "name"
          ]
        },
        "annotations": {}
      },
      {
        "name": "pods_list",
        "description": "List all the Kubernetes pods in the current cluster from all namespaces",
        "input_schema": {
          "type": "object",
          "properties": {
            "fieldSelector": {
              "type": "string",
              "description": "Optional Kubernetes field selector to filter pods by field values (e.g. 'status.phase=Running', 'spec.nodeName=node1'). Supported fields: metadata.name, metadata.namespace, spec.nodeName, spec.restartPolicy, spec.schedulerName, spec.serviceAccountName, status.phase (Pending/Running/Succeeded/Failed/Unknown), status.podIP, status.nominatedNodeName. Note: CrashLoopBackOff is a container state, not a pod phase, so it cannot be filtered directly. See https://kubernetes.io/docs/concepts/overview/working-with-objects/field-selectors/",
              "properties": {},
              "required": []
            },
            "labelSelector": {
              "type": "string",
              "description": "Optional Kubernetes label selector (e.g. 'app=myapp,env=prod' or 'app in (myapp,yourapp)'), use this option when you want to filter the pods by label",
              "properties": {},
              "required": []
            }
          },
          "required": []
        },
        "annotations": {}
      },
      {
        "name": "pods_list_in_namespace",
        "description": "List all the Kubernetes pods in the specified namespace in the current cluster",
        "input_schema": {
          "type": "object",
          "properties": {
            "fieldSelector": {
              "type": "string",
              "description": "Optional Kubernetes field selector to filter pods by field values (e.g. 'status.phase=Running', 'spec.nodeName=node1'). Supported fields: metadata.name, metadata.namespace, spec.nodeName, spec.restartPolicy, spec.schedulerName, spec.serviceAccountName, status.phase (Pending/Running/Succeeded/Failed/Unknown), status.podIP, status.nominatedNodeName. Note: CrashLoopBackOff is a container state, not a pod phase, so it cannot be filtered directly. See https://kubernetes.io/docs/concepts/overview/working-with-objects/field-selectors/",
              "properties": {},
              "required": []
            },
            "labelSelector": {
              "type": "string",
              "description": "Optional Kubernetes label selector (e.g. 'app=myapp,env=prod' or 'app in (myapp,yourapp)'), use this option when you want to filter the pods by label",
              "properties": {},
              "required": []
            },
            "namespace": {
              "type": "string",
              "description": "Namespace to list pods from",
              "properties": {},
              "required": []
            }
          },
          "required": [
            "namespace"
          ]
        },
        "annotations": {}
      },
      {
        "name": "pods_log",
        "description": "Get the logs of a Kubernetes Pod in the current or provided namespace with the provided name",
        "input_schema": {
          "type": "object",
          "properties": {
            "container": {
              "type": "string",
              "description": "Name of the Pod container to get the logs from (Optional)",
              "properties": {},
              "required": []
            },
            "name": {
              "type": "string",
              "description": "Name of the Pod to get the logs from",
              "properties": {},
              "required": []
            },
            "namespace": {
              "type": "string",
              "description": "Namespace to get the Pod logs from",
              "properties": {},
              "required": []
            },
            "previous": {
              "type": "boolean",
              "description": "Return previous terminated container logs (Optional)",
              "properties": {},
              "required": []
            },
            "tail": {
              "type": "integer",
              "description": "Number of lines to retrieve from the end of the logs (Optional, default: 100)",
              "properties": {},
              "default": 100,
              "required": []
            }
          },
          "required": [
            "name"
          ]
        },
        "annotations": {}
      },
      {
        "name": "pods_top",
        "description": "List the resource consumption (CPU and memory) as recorded by the Kubernetes Metrics Server for the specified Kubernetes Pods in the all namespaces, the provided namespace, or the current namespace",
        "input_schema": {
          "type": "object",
          "properties": {
            "all_namespaces": {
              "type": "boolean",
              "description": "If true, list the resource consumption for all Pods in all namespaces. If false, list the resource consumption for Pods in the provided namespace or the current namespace",
              "properties": {},
              "default": true,
              "required": []
            },
            "label_selector": {
              "type": "string",
              "description": "Kubernetes label selector (e.g. 'app=myapp,env=prod' or 'app in (myapp,yourapp)'), use this option when you want to filter the pods by label (Optional, only applicable when name is not provided)",
              "properties": {},
              "required": []
            },
            "name": {
              "type": "string",
              "description": "Name of the Pod to get the resource consumption from (Optional, all Pods in the namespace if not provided)",
              "properties": {},
              "required": []
            },
            "namespace": {
              "type": "string",
              "description": "Namespace to get the Pods resource consumption from (Optional, current namespace if not provided and all_namespaces is false)",
              "properties": {},
              "required": []
            }
          },
          "required": []
        },
        "annotations": {}
      },
      {
        "name": "resources_get",
        "description": "Get a Kubernetes resource in the current cluster by providing its apiVersion, kind, optionally the namespace, and its name\n(common apiVersion and kind include: v1 Pod, v1 Service, v1 Node, apps/v1 Deployment, networking.k8s.io/v1 Ingress)",
        "input_schema": {
          "type": "object",
          "properties": {
            "apiVersion": {
              "type": "string",
              "description": "apiVersion of the resource (examples of valid apiVersion are: v1, apps/v1, networking.k8s.io/v1)",
              "properties": {},
              "required": []
            },
            "kind": {
              "type": "string",
              "description": "kind of the resource (examples of valid kind are: Pod, Service, Deployment, Ingress)",
              "properties": {},
              "required": []
            },
            "name": {
              "type": "string",
              "description": "Name of the resource",
              "properties": {},
              "required": []
            },
            "namespace": {
              "type": "string",
              "description": "Optional Namespace to retrieve the namespaced resource from (ignored in case of cluster scoped resources). If not provided, will get resource from configured namespace",
              "properties": {},
              "required": []
            }
          },
          "required": [
            "apiVersion",
            "kind",
            "name"
          ]
        },
        "annotations": {}
      },
      {
        "name": "resources_list",
        "description": "List Kubernetes resources and objects in the current cluster by providing their apiVersion and kind and optionally the namespace and label selector\n(common apiVersion and kind include: v1 Pod, v1 Service, v1 Node, apps/v1 Deployment, networking.k8s.io/v1 Ingress)",
        "input_schema": {
          "type": "object",
          "properties": {
            "apiVersion": {
              "type": "string",
              "description": "apiVersion of the resources (examples of valid apiVersion are: v1, apps/v1, networking.k8s.io/v1)",
              "properties": {},
              "required": []
            },
            "fieldSelector": {
              "type": "string",
              "description": "Optional Kubernetes field selector to filter resources by field values (e.g. 'status.phase=Running', 'metadata.name=myresource'). Supported fields vary by resource type. For Pods: metadata.name, metadata.namespace, spec.nodeName, spec.restartPolicy, spec.schedulerName, spec.serviceAccountName, status.phase (Pending/Running/Succeeded/Failed/Unknown), status.podIP, status.nominatedNodeName. See https://kubernetes.io/docs/concepts/overview/working-with-objects/field-selectors/",
              "properties": {},
              "required": []
            },
            "kind": {
              "type": "string",
              "description": "kind of the resources (examples of valid kind are: Pod, Service, Deployment, Ingress)",
              "properties": {},
              "required": []
            },
            "labelSelector": {
              "type": "string",
              "description": "Optional Kubernetes label selector (e.g. 'app=myapp,env=prod' or 'app in (myapp,yourapp)'), use this option when you want to filter the resources by label",
              "properties": {},
              "required": []
            },
            "namespace": {
              "type": "string",
              "description": "Optional Namespace to retrieve the namespaced resources from (ignored in case of cluster scoped resources). If not provided, will list resources from all namespaces",
              "properties": {},
              "required": []
            }
          },
          "required": [
            "apiVersion",
            "kind"
          ]
        },
        "annotations": {}
      }
    ]
  },
  {
    "type": "mcp_list_tools",
    "id": "mcpl_0692ec3cf987cc89006afb8766bd608195ac70be120a6c6871",
    "agent_reference": {
      "type": "agent_reference",
      "name": "k8s-incident-investigator",
      "version": "7"
    },
    "response_id": "resp_0692ec3cf987cc89006afb8766a4d081959ae930969478f280",
    "server_label": "prometheus-metrics",
    "tools": [
      {
        "name": "health_check",
        "description": "Health check endpoint for container monitoring and status verification",
        "input_schema": {
          "type": "object",
          "properties": {},
          "required": [],
          "additionalProperties": false
        },
        "annotations": {}
      },
      {
        "name": "execute_query",
        "description": "Execute a PromQL instant query against Prometheus",
        "input_schema": {
          "type": "object",
          "properties": {
            "query": {
              "type": "string",
              "properties": {},
              "required": []
            },
            "time": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "null"
                }
              ]
            }
          },
          "required": [
            "query"
          ],
          "additionalProperties": false
        },
        "annotations": {}
      },
      {
        "name": "execute_range_query",
        "description": "Execute a PromQL range query with start time, end time, and step interval",
        "input_schema": {
          "type": "object",
          "properties": {
            "query": {
              "type": "string",
              "properties": {},
              "required": []
            },
            "start": {
              "type": "string",
              "properties": {},
              "required": []
            },
            "end": {
              "type": "string",
              "properties": {},
              "required": []
            },
            "step": {
              "type": "string",
              "properties": {},
              "required": []
            }
          },
          "required": [
            "query",
            "start",
            "end",
            "step"
          ],
          "additionalProperties": false
        },
        "annotations": {}
      },
      {
        "name": "list_metrics",
        "description": "List all available metrics in Prometheus with optional pagination support",
        "input_schema": {
          "type": "object",
          "properties": {
            "limit": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "integer"
                },
                {
                  "type": "null"
                }
              ]
            },
            "offset": {
              "type": "integer",
              "properties": {},
              "default": 0,
              "required": []
            },
            "filter_pattern": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "null"
                }
              ]
            },
            "refresh_cache": {
              "type": "boolean",
              "properties": {},
              "default": false,
              "required": []
            }
          },
          "required": [],
          "additionalProperties": false
        },
        "annotations": {}
      },
      {
        "name": "get_metric_metadata",
        "description": "Get metadata (type, help, unit) for metrics. Returns all metric metadata when no metric name is provided. Use filter_pattern to search metric names and descriptions.",
        "input_schema": {
          "type": "object",
          "properties": {
            "metric": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "null"
                }
              ]
            },
            "filter_pattern": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "null"
                }
              ]
            },
            "limit": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "integer"
                },
                {
                  "type": "null"
                }
              ]
            },
            "offset": {
              "type": "integer",
              "properties": {},
              "default": 0,
              "required": []
            }
          },
          "required": [],
          "additionalProperties": false
        },
        "annotations": {}
      },
      {
        "name": "get_targets",
        "description": "Get scrape targets, with state/pool filtering and optional pagination",
        "input_schema": {
          "type": "object",
          "properties": {
            "state": {
              "type": "string",
              "properties": {},
              "default": "active",
              "required": []
            },
            "scrape_pool": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "null"
                }
              ]
            },
            "limit": {
              "properties": {},
              "default": null,
              "required": [],
              "anyOf": [
                {
                  "type": "integer"
                },
                {
                  "type": "null"
                }
              ]
            },
            "offset": {
              "type": "integer",
              "properties": {},
              "default": 0,
              "required": []
            }
          },
          "required": [],
          "additionalProperties": false
        },
        "annotations": {}
      }
    ]
  },
  {
    "type": "reasoning",
    "id": "rs_0692ec3cf987cc89006afb87679bfc8195bea49e29bdb42c06",
    "agent_reference": {
      "type": "agent_reference",
      "name": "k8s-incident-investigator",
      "version": "7"
    },
    "response_id": "resp_0692ec3cf987cc89006afb8766a4d081959ae930969478f280",
    "encrypted_content": "gAAAAABq-4eD-f6FbDNG26bz6FCKZcqpg5OSoAS9xv74QtJQOGxOBZSY6UNw1k-tgi8Lool9KKUFJGmUyaGFCn_FZIwvKNENecnmknfP-3KotpYloOAg68WifIUt0yGJmfpBmX2ctRQIShBIdZ33MU906k17PoqVrxMNUCv7nEoaUdU2HQ31yWgLWHEL36OkFjwx_3nxnG617OW1sNAy4TN5ULvVPJi144-2DlA_meFQBTRtxJKs4u3mvpWMwrUTrOcJf_mEmvRklCqgVMpqviLMkmeFTdSEvPxvYx5MV1Ip04OkQQL3p7C31xfhEPHxy5HzWlFEVSQeeX97HJDuoJSLCON2l5NFg1MFOnPkAERijLYpX91hnfYqxPJxXq07JbAepdQIFpWzhlsMd7AMaBr6KItYbpHehCTBkSKcEwInBkIJCLfsDNraGNC5m6a8mpI_dKJbvkiHke2pIfIHxuQISThL9kYqdKckWRYPMQ-U66Ze_gf37PyFm5w94N6rLa1bX02aM4EvNC8uvzLkjjO2z4mhGuTLZaC8WHBa4xPjhEpLcD9QlVjjvCI20Cjd-eVVYVhHwMdBv9nRegNwBFBLo5kHGI8xW64k9UAm0w9ZbsfCKrjUbM8u5rExG9PdQj9ltCzsdJ6uO5rzdIzwFiN_Kia70bVg6IMS0vCoHNVQL9aS7rGDmtwTDiP6ipdK_06qhkeIdNT9yhg6SXH4jca5FYjG_gJePNCtHSWKB1eyqHKHlCpeKpNkOGkMM-eJPWLMzO5wCPAW20_xXBZ-KY9YsPknOxCORnPjkxrFhpVoqbXzqlXTnAqFVpKfxuZDRJtWHQhJYIiafhWVPuTGmds4YQiThf9lCDvym-gd2XpLQqdSPrvDZ22ZF9O7pyPGgwUNKKBnVrbwZVKsjd-Wyb4eEk00yyjiURCCwaZaYkEAiS6seBHLZYh6rEjLfepyvZU_S8N4YZ1oBpnvLvbTkFcai0wNgv8R7W4Yyp9Z62CCGIS0akzyBB47k3ltVNHDSwEPXMbVWccF0QNEKuU_U8kfa7ZL2iKUEr7_wuw29q3F7mfs2U4BomttCc3lfV3kpGekVFyRqkdQjNI5ngxMx4DPAk5U5hIhZLl5W1pkpd8jftJdqn7iVSKgWIFWcMOtMI2yuR2EWmOT7MhDFngHQz4JuWS-scdkeBq0wm3yIvwKfzOqiSfkU-jwrHjNWoRzqSluGZD4OIGRLUGcI5oP8dZEZ7t0qEriAhtiUtHKaIF7HD3zJANCK0HfjPUk09Xjg_5yE2FX_E63L9MQd5vyNP-7v1TgsV33SCYkLypuI7GvdC0_ytG_akW1mb3PauVrR0lpUFLpWJ5n6hhkEQ5JKAjzxTMg5IPkjyGXsbzip8VhEvCuKvJtstQXFulfRrhbvrRbzt8frO_gEec93xW_9HP2T7ZGxL74Sauv1Xh1J-bDb8quoBKaVwp4c-uokitXitIhaH3R0lw6pT-eD1Fs_qYSNGQkKM3z4PG0RGzUn-_q0lFrbQD8T7RjG8nsc3lmxVp3jf2D0DrFL4IsI2lMnEc-s5eSVVimuDDft68mWna9O5y2Yzsr0q_Hi9h26IFPW7eUUUy99CTCnpqjbsiKicZ_9NThYaoT3_mmtm2ICk6WxtAStlQLdPgniPOq1GyAdvPuYUtXZs5HMrNCo2Bjsody66a9U7VPpG7jO269vDY5MovRzy4IqHKXcLPHKMqZyckORA6H8cJ9Lz80QIIUS8ajmqRXOES6LfRXG68SWKFZDcXJYRcA8jnjVU3ZwZO_7bR0cO-Cked3_1Xb52twM5GXl_MciIrZz0w_7iljgxPi_9PAxMlVWgNtYoOvIxlAigvWxiKIdh_82IzOWh9wqnkSjXcJ3LdWyp5D8SHsdF1a9EXyKL3ScmEoVEkIbL8nZ3y3qkIxTk5yHWxx-iBnvlJyw6Y8l0_2hQgCjU9QrKO5h3eHnnfvjKAPFcwysHCh-tSFtl7m-0IM-NFuoIhwr1Qbmk2QXcj6Df5SefrO41XezWLhPf7Q5tEL1tHSW19T6-PTyrV2Yp6e0hj78kdl2ez0suaXbLBBRsLW-R20snuXe9oVa4CF3oFo6IZ_CQooZTp82xgDjElmyAK82vMPTzdjsruwYiIX3cMx0VamF9awhjczjhVYSS_mA03KDzb7YY52g4zPenegVb5kTgAlZSprUcMBpo8-Y9Sap8MTgWNuqo5jDNXgj5T8oN4RlB0exzW7WljB6lzJEECxYOsSlKD7X88Qpu4gPWGZtXIbIa6XHcqpq5o6Qfu6tO1Rlwtsrqkofqx0KPVzRVmWGTvDskQ1xlZwkOzLwdI8RGGacjJ1Cr6OS4VNSk9bXRXOwLVhqOk7nSwmd5Xm81StmYxLmG-sR_3hOGhWQuF2Oe5APTXP95tB5KXcty-EbxJiC8iCTndfqkhdPH5juizX3vraLfw5VVOHFE_tneQl5tec1rKcZm2iNY0XjosNAKHaajuNovq1aG51uiG3qUkXXlJCXX-S7W6B7k4A2_UWW-cDFjW7YmcWMFBo2mxKnvT7odrJBmnUrtmRNxV0rS8tmLrhZG9mzJ2yRrJFo0zRiZVJTPYi1xeNHInC_f3AaY1LRLVAo_oTpoLKgw35LHlJremQSXTyrvSsxQTzQJBMIv5z1xnB8mTToxXThzRDxwLeH9bb-vkSnRqzssAuF_3ISnXGRlMJH_zjTbSDzbNcyQPKHaB4xPfEAzJvM40-uu8GTyHt2TVq9ojiuMjrj1dqqinFF6jt5G9Mh2ftFxtxC-sMsRXGTbrwtThEAZe6NiWF9ZpZ3wIP5QkFU1gG_AJGtCVJbKi0YzbR7bqGAnOrsBR2pvz0kw9AyWn2DAN6OBjPdrysZNwrdzCYVDRAqnS3lXyZmFNYW1L9qd_OWbViNqpiMCBa7J2MNakWZIu8yfPjuXzj9YT_ulF6ydynfa40PqajckpdI9vH6ybSQsVCxBMeN_o_4taisw9KTahWibJRc--nJzQs2jZoF0Mg71kXv_aEfVgzsBd4JSgKwhB0x_66Co-QAFaXCsPOnTwBFvwszDJGbOOoMZY4nAGX6ZPou9nmQOsEXzo9bClN3PP9m6F0Gsu1Z6gb0XxQWZ48MMoFlXUSyRo5G8Ipullx3NkPxrWKBP6BeYejAqt0wc8aunrCxd3x2xiqGKaDoFBsvrbaVsSGJj__YiNeLIGvODx16_3QZoAEh0P590o29sF-9-vxv_iBv9f5Chi7IOc-nW9KUMNFdKiNyDl9NqH8W2Gkl7fqoRfS4SlYAi74VWQxgbU11oALktfdPsYB3oE2d3jFtHXbAmrObSoVk0f1GL2CqXT_Z59en3DGq5-gBJ0VAIjY1clINEe7ertvGlRcu4OApOYioRmybffg7VuzonM37UfiEu1uXEWwSsSj5JMB25DIHJiht6X0HzXe13xDcRELDf0pkDQGcO64Wva5Hb771_m8qJRhZPSkxZ8fTfCGX4rWgxrsJ8Hh1oC2aEHblKPTWo6aWdM3rmIj9FVPj5vQfNKBSX_FdtK2Wk23YEN-9GyoVcXxCtWPjQY150G7sE6mfEgpR5fuvqN-BOYZ0DvFl5OQI-rLMxm8YdUtjZtOAdzxqbbHwncjaFnIl8HZglPSti0YUEX2NLBRFfsHnkQtHnzL5TJE8MpxdWCFFfMYl7Pi6asI-7Lp5reOsiILELLq-PyKQ9bX9GlDehJwvNHWfEQ5daxjqU8XEgD2yh0kUwS80O35Fbk48uAAYdqh26_J9wswUK3Dabg-N7OyBkShZ6_oYt5ZS-c30iL4c54BghKvWlOoahD9kXDKmJ8RJOvp3Fb_5JgW-7W0Fm3raUMgyh5XRrGiVZrvKQphoVUJYrtNtk2YkheKsGTXrBTKE6tpOVmBiLtHvf9ECyEQBWp68Agcmx07MkPNG_xSl7rOjPEB5ThDj9rzp55wSCuNauxCCzEY5HUL1uNocFoKSch86HNHBpB9Hscwl0p2QLuhpEganjQvd_VqggSUoVzIaD39cDUXyXNGRJn_ZAM3V6AB59-8Ulpp34BtNhpYEEReWwXcF2n_CyveJPohffCvxFr-Oa9wq__rtbtVRsUX2fKnQ2ojwAGWpkggxkrckjhojZAm83EhDiRGaA2pNGTMTsVH7OEX5NaY6GJ6e3zOwXjofCc7aVmdBDZMfgSz-fuc_0LTCFZdRO-uk-_gGByPLSXG33uApriupjK-wm6ndyvsESmCipQQEX88kyHf-Ox0X-0KHjq3-OiCYc9UMi7IwHV7ww7VXn2raKdVdl1-r2msLP1BSyvLlcC0dPpCJx2XLFrEopYibOnjq6iqr98W77gtYAk97hp5jR8p024rKM5ff3spg0OXZvhf37IyewN8IsS4flOSfaYvAhTLn6ei-nTz8mZuP4EB8dLLO4qHmqa8VOO6d_tJw09FJqqcZxKp9dMronU57HPTnDLfJhTkFokrk2ylT5v8-xtQ1qGxts0Otribrjm_XLLmf7tLp77qmhNvfSm3kUH9cSU0LoIthlfA0WiO__yG2SuqirmxEyfnAM_HCNNTVpleGpmIXs0P2T-sKSLOAgxanhK72Z9GOnni7Z9ns9YLs-jMA-Nx-KkxEi-Ocbc013ZVMlLp7yIi1Vhjf7ZOAJ3HMEbahNrVhIQSzCq5e1Z5VDjwD0CPseOP25OWjwIomGyNoe6x9Mf9cTp9aFiODoSFimxNZfAzzkXQU3NaS2dorzrlrUNH4AagNgEOULsIA44yva009-UqRVYEswMI4LdXhNh4ARyXuismfwyo_XCvgz2M-e9qugJ429-UP3JcDCDgm5arGVVu02M12z9sINJbulPKXuosIbkrCCAEobI04QiMfrHm66YuLCbxAQ53lD7yzemezOfneT1cjhKxA3-pRozO56UovNWYiFvhXH8Jyw_SM0fqmG40PCbFceJJ9bC3HLem7sBY7B331Kw1BFnSuMcwO52X3WKiYy5JykRZMjxYBBpLBdSEPVwJTfvg_2TK9gzMq5kooZMwti8OmbbUSc7nnGEeb87wCI_s19oeXL-PAwALySgKOAUasOeLPsXsKouYHzz4TeFegCp8BCSbyk9FTj44OApPYnnWnkIwSvkZ8iFwy_ofd0VcSZZimlFemh3pMuz1O7t2_pFgAusMtPFL8H04VClNawLREvq6W4mayAXySFw0jV0EfjLsG8n3xFsGmaj8lw2Hsp0NoGq6ZH6--JLYOy2wuh6lTWG6vATXerZxpXBZ-xOQJSwH71pyr4q81dviL3axQtnGOsitJnCfzUwE1LK9_QO76lGb5pevE5LCySM8jY2VPbTo-tAfY6ziOZBYjkJCpXIF7Rt3QH5TvjvUIxXKMRyNlpoQdTcVAV29j0gLJ3Rl3g2n4S_9kGvlxwTa7TOkztK-w1G-raQ2ZIEi9hG1pDZs1DaHy-CSdADt97GF9vltEqDutrgNAIVJVFXGFSU_1t7FkTrChIm1xEjr4ol6zzhl1vazIeWNFrtyyynyxsCgSgW_IfgqpJGzFq6lSvVzaNRJydxFPbjnAN9EXg9SGcFm8MJAZAmkCvN_9a6x6FD4KOlU--zrR4BABbPrZh3eJ_rFwOj8aSCmK5uGWjyqEJcYjGGuweL7cnmDGEwzZpMe060_BKB-uEMI3BzC7tGiciwDXZYmmYbuinJN9R48LTWv50YMVflwZ80MCahSGRK-rnKYOBnk45bcVoo0oZ6TCfFQ5d5GuD9lT-EOShUcYBmhHXBB5B8yvGt9Q_ZldQsa8X2OHszPuAWHcVBOvRRwxuMLb_Oty5BNPVj9OTotu5-5iWzRBGbRPoNpgzxlxmcv3ignjyKb6IwyhaLNdjAvwtAndRH5chb-QlBuH-nNj-Z7llSjnLycRNLVA3YuvODa5vjtHTvmFzfbI0gnZhA7uebqa4iEE2ncQ_-DJBgRpyhHF4X9TIhPzpBo2rB9ua4_nzaNK6YqKDL69H8XI-DQjYFlJK17mV-5uGA931eVZ7oTy8CCOPUwOxz6WoPDkvi6EXdD2-FBcFwhVnmxpc8g7YAYERBoWApr_ZmRP66Db00ii5dH_M5sqvIFpkV_qVSSuFgwb9UkGapw1hKMV_VouQ1fQPAoardZbu7UAZ7SUkHz5rUd82jRqaW-L7cLa1vshmt3TwTBO7nkJcVTjxPZaYtwk0j-w19m5QztNGdtIO4OKSZTUmV4lQZrtKALxJsq12lFi1ojwCnPej7YOeqYApl0LzOUtlVwB_H79faWn93I8_r8ORWE3JYlvAoOjD7HPYXv3cQcYS-NJ64DDMNySl18xGBU1CAIe5NFrowSEq-U0HcTQCBx_U34MBUAaNqLJk2GIwiiMLQtO-f_-fpVL_h-rdALRMR-v-WuUHEaVnVWGiPxllkCZfLjPvZXLUXcAzRArVtjSu7N5tIPV81wIbNjTIkbT76CcQcMX-rk1yBEtqdT-oHjS5KzWveMZ5_J_e1E-eUDrT1wlyZzz-0Rh45NeWjpicFOWHeYWST-DW9HK4DBzGCk3uQSgjMGdjjmZFv1BDfUCDqInHaVQ5vPUDUxkiDie0HPRy_5euS8tpFfYwlA-UOhiPiBo6dSFM5dl7on7yaCGM3d7Wii21Wcrn8qorQjOvrHFf6lTUO1GKwf6pok0lrwGyc8jgS_F6RsU9ZDVvTIgarpMMpAf7J9hXi17qWefzbg3czwDFVLvtoRMmJbgq7G9fJwJV8vmPfIYFegaZNJ-GxxheB8N1ypV-7BMHhdzlWRFXisseKbjUN-v9YLlurDQ480ZdyC8K3EAwIJdW-coa8R5Fqa983A7UuPgBpw7i4s1didykJZuqw65I_evc0OjJssc18brXBd4a9z7P0nGYpjYgPDgfJISN0-gcQSrvGNWg8OIbfl1M-6V203J1pQcrKIFTDMx-BL8FmRlB751pqL-TiDVR-5YxrKuzwGjAXFmKhj7vcp2NQrc2I4DJujy7-sAZKt8iInobfvStIbQ-GNkXJEZkAqzmnKKak4NLKFFjO0T0EZS5nMWXeWMtVSyGuUHDvYp081CiXGUwEiy6ALe9nOPAhuwCHmlO8Mh0qlkhMnNFr29mTXOCdbWQ4Ww9paoWfGfQOwWpKshJy7vgLOyjzK0HXNf24Ig4T4O7K8cDasLfoIXbqmfhBdui-lotizxua9sYfBA11yAW7-igNi4qOmThb804yi4sfJrs7H7iqEfctjWjt0xRvuJHQB5MzH6fw7VM6rjiNVrfXLs23-1_KZILCCw74gFsRrWPx6gFVqai_TY__Y9rO-GJyjO_4j33uS2_60TgpG4bmwrpKSZ1m9LAvxDkM_g3QBgvYcsEBxGtlfwUjAKT9grF2cUsUdN4Xo4LIoShjBGXnOoDa6O8EsnKK9k-GZkr39_rvRyF1HtHTtCaUR-K9PEIOs1gi_9HLY4UoyLHmPIenyhOOsYOeVhd2VfAKb3K0d7yaJ3W4BU5Y3phZ0qbjf8BbY50LTclUB-E53CzaYgd96U293dOXJzofm2QuMF826NYE3D7grkZv8WeYqHw55m1LTgV7dusvLGBMmPayFIxfN_7RxgW6bo4kddRvBEzW6zuMlxzsw41kP-288VD1Oxh5fduzuSrIp1ihpKZyC5fo_1yNUp2N_r58MuVzL70IlJwdKmJutv5H2HCKwKdSFKx23D4ocC6w-JeozEbPCDSNH1zoT_p_-K7LlF0qRWrI_W1JoeS4YDVGDYN3pHAcwCL4FRXtPffI3CUAvNPA-8uyt8goQUzUbUdVYE2CCe77bL7ORiXaDukuqPJORNPIHhRfvlpJANE2Z-cu8KuvPKwK6R1MQPn_vObcW8O8tfncHD837UCvtPxLukIZJE0JYcqFr6N4U8E32rZjInpNBaUS2DeyZHjBQ3zPncxf4eHaHAKhO8_cK1Pf_ItlbsDzWAK7cBzoG8iJtxgo_WyM0xlmjhXYCD22KSLKJH6F-UwvfcYXSZ1kQMbjTNz9FRdvCj_mogAbNZcYsT6kmkWKbQundQWGK1Gmlu2Qp91PpCm43XIuoc34m45Rvs7ClruFVqDJu5hFDPdKzKO_tz_n9uu977pWuM3d-LGABc-wUQl1AFwg_Hkqc1l2jkFSjCB-QRbwcBJndqhwL2G-BtA3QpL53XyCfusjdcO-Uuy467QmHblu7PQPlBCgIFiO4DychTfRkk75feRVGpKIl7BhOm4UjkEfUHst-vCwohjHxBBi75S1GZrTNF2lY5CH6dMP2IFgfjo-uY_5Jaf9bSd3oH3uF_7nWMrNBsDkDSqIs2c8QXudUiwVxxG8q4cyy3XkR74oZEBKrXeu3RCT8GCYzNmSaE2-za_VNmF2zVLgKPqJV1wPaFRQE2hmNNHNtxmBE0ZUhWr2ItlfjMtb7MVR1rFBizNRYWzb75SPGAfvkTr5J5lPfdp4tBn3QvwaP81hRlm562acMcLQTzYaRdfYx4M02c9fx62tpx5sfJj6Z-xaZEW9C3KcjI1MiwB2E9KmHvg_B7R6vkRFJggDZuTMeKDfirE7bbApdQiihquT9akjoLKX975qp-MVd8Do-BnP6j445b3D_W9QOT2M8Cw7wS88tfF7ofP0IjZdFCjIhotQwQg9FNIoi8n_YITAYnppBICIdlAhPheI7YZ46_M_lCkWYapkfGhP6dj3VD06OmIVgXF-gjkxnGX09kiaDjtQvlPPQ2O7J526a1lUcqsrsXMRxqACkapbIpc3HHpMdTeXs_Fll8AvFeM3vSgWPLlJeQyeG0iagREno-X6J1rVzZtP1d3qcx7YofQyzDfjoyaJmohagtSU=",
    "summary": [],
    "content": []
  },
  {
    "type": "azure_ai_search_call",
    "id": "fc_0692ec3cf987cc89006afb876bef50819587290ec72a762546",
    "agent_reference": {
      "type": "agent_reference",
      "name": "k8s-incident-investigator",
      "version": "7"
    },
    "response_id": "resp_0692ec3cf987cc89006afb8766a4d081959ae930969478f280",
    "call_id": "call_1d4f40b4ff9c41d3a099d0010afa28a9",
    "arguments": "{\"query\":\"jackson-databind 3.1.7 vulnerability, alpine packages vulnerabilities busybox 1.37.0, gnupg 2.4.9, HdrHistogram security, ca-certificates alpine advisory\"}",
    "status": "completed"
  },
  {
    "type": "azure_ai_search_call_output",
    "id": "fco_0692ec3cf987cc89006afb876c8230819595b651155b0c0818",
    "agent_reference": {
      "type": "agent_reference",
      "name": "k8s-incident-investigator",
      "version": "7"
    },
    "response_id": "resp_0692ec3cf987cc89006afb8766a4d081959ae930969478f280",
    "call_id": "call_1d4f40b4ff9c41d3a099d0010afa28a9",
    "output": "{\n        \"documents\": [\n          {\n            \"id\": \"aHR0cHM6Ly9zdGZrdWJlc2VudHJ5ZGV2LmJsb2IuY29yZS53aW5kb3dzLm5ldC9rbm93bGVkZ2UtZG9jdW1lbnRzL2FnZW50LWtub3dsZWRnZS5tZA2\",\n            \"content\": \"# AI Incident Investigator \\u2014 Azure AI Foundry & Kubernetes\\n\\nAn AI-powered incident investigation agent built on top of the **Azure Kubernetes Service (AKS)** platform, designed to assist with **real-time Kubernetes troubleshooting and observability-driven incident analysis**. The agent connects operational telemetry, Kubernetes cluster information, Prometheus metrics, logs, and the project knowledge base to investigate incidents, identify potential root causes, and provide actionable remediation guidance.\\n\\nThe solution is built around **Azure AI Foundry**, with secure access to Azure and Kubernetes resources through **Microsoft Entra Workload Identity**, avoiding long-lived credentials inside the agent workload. The agent can interact with the Kubernetes environment through dedicated tools and consume observability data from the monitoring stack to correlate application behavior, resource usage, and cluster events.\\n\\n> The AI agent is an operational extension of KubeSentry (Agentic AIOps & GitOps Platform on Azure). It does not replace Kubernetes, Prometheus, Grafana, or ArgoCD; instead, it uses the information exposed by these components to accelerate incident investigation and troubleshooting.\\n\\n> The complete DevSecOps, GitOps, security, workload identity, autoscaling, and observability architecture is documented in [~/hajar-azure-project/docs/devsecops-README.md](../../docs/devsecops-README.md).\\n\\n---\\n\\n## Architecture Overview\\n\\n![Architecture Overview](agent_architecture/architecture_agent.png)\\n\\nThe AI Incident Investigator sits on top of the existing Kubernetes platform and connects **Azure AI Foundry**, **Kubernetes tools**, **Prometheus metrics**, **application logs**, and the **project knowledge base** into a single investigation workflow.\\n\\nThe agent therefore provides an intelligent investigation layer above the existing **DevSecOps + GitOps + Observability** platform, while preserving the security boundaries and identity mechanisms already established in the cluster.\\n\\n## AI Incident Investigation Agent \\u2014 Complete Technical README\\n\\nThis document covers the entire AI/agent portion of the DevSecOps portfolio\\nproject: scope, architecture, build steps, and every real incident\\nencountered and resolved along the way. It supersedes and merges the\\nearlier `agent-knowledge.md` drafts, the RAG/Knowledge Base notes, and the\\nAI Security Review notes into a single up-to-date reference.\\n\\n---\\n\\n## 1. Why this exists\\n\\nThe existing DevSecOps pipeline (Terraform, GitLab CI, ArgoCD, Kyverno,\\nPrometheus/Grafana on AKS) produces a lot of signals \\u2014 Kubernetes events,\\nmetrics, security scan reports \\u2014 that a human normally has to correlate\\nmanually to diagnose an incident. This project adds an AI agent that\\naccelerates that correlation, without replacing the underlying scanners,\\npolicies, or GitOps controls.\\n\\n## 2. Scope, defined before any implementation\\n\\n- **Single responsibility**: diagnose, never act. The agent has no\\n  write access anywhere \\u2014 no scale, delete, restart, or patch.\\n- **Namespace covered**: `dev` (where `portfolio-app` runs). The\\n  `monitoring` namespace is queried read-only for metrics, never\\n  investigated directly.\\n- **Data sources allowed**: Kubernetes API (read-only), Prometheus,\\n  application logs via the Kubernetes API, and a documentation\\n  Knowledge Base. Azure Monitor / Log Analytics was explicitly\\n  excluded \\u2014 Prometheus already covers metrics, and adding Azure\\n  Monitor would duplicate cost and complexity without clear benefit.\\n- **Mandatory response format** for investigations:\\n  ```\\n  Root Cause: ...\\n  Evidence: ...\\n  Impact: ...\\n  Recommended Fix: ...\\n  ```\\n- **Success criterion**: reliably and repeatably diagnose real or\\n  staged incidents, citing concrete evidence per tool call \\u2014 not just\\n  occasionally producing a plausible-sounding answer.\\n\\n## 3. Final architecture\\n\\n```\\n                         \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n                         \\u2502   Azure AI Foundry         \\u2502\\n                         \\u2502   Agent: k8s-incident-     \\u2502\\n                         \\u2502   investigator             \\u2502\\n                         \\u2502   Model: gpt-5-mini        \\u2502\\n                         \\u2502   (GlobalStandard SKU)     \\u2502\\n                         \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n                                        \\u2502\\n              \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u253c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n              \\u2502                         \\u2502                         \\u2502\\n           MCP tool                  MCP tool                Knowledge Base\\n         (Kubernetes,              (Prometheus,                  MCP\\n          read-only)                read-only)             (Azure AI Search)\\n              \\u2502                         \\u2502                         \\u2502\\n              \\u25bc                         \\u25bc                         \\u25bc\\n   \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510      \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n   \\u2502  Ingress (Basic Auth + Let's Encrypt TLS) \\u2502      \\u2502  Azure Blob Storage   \\u2502\\n   \\u2502  namespace: ai-agent, scheduled on the    \\u2502      \\u2502  \\u2192 AI Search Indexer  \\u2502\\n   \\u2502  \\\"monitoring\\\" node pool                   \\u2502      \\u2502  \\u2192 Index (365 docs)   \\u2502\\n   \\u2502  \\u251c\\u2500\\u2500 kubernetes-mcp-server                \\u2502      \\u2502  \\u2192 Knowledge Base     \\u2502\\n   \\u2502  \\u251c\\u2500\\u2500 prometheus-mcp-server                \\u2502      \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n   \\u2502  \\u2514\\u2500\\u2500 Prometheus Pushgateway               \\u2502\\n   \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n                       \\u2502\\n                       \\u25bc\\n             \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n             \\u2502   Cluster AKS       \\u2502\\n             \\u2502   namespace: dev    \\u2502\\n             \\u2502   Prometheus/Grafana\\u2502\\n             \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n\\n     \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n     \\u2502  GitLab CI \\u2014 job `ai_security_review`                 \\u2502\\n     \\u2502  Dedicated identity (AI_REVIEW_CLIENT_ID), separate   \\u2502\\n     \\u2502  from the ACR pipeline identity, OIDC-federated,      \\u2502\\n     \\u2502  role \\\"Foundry Agent Consumer\\\" scoped to the Project  \\u2502\\n     \\u2502       \\u2192 summarized Trivy + SAST + SBOM reports        \\u2502\\n     \\u2502       \\u2192 AI-generated analysis (ai-security-report.md) \\u2502\\n     \\u2502       \\u2192 success/failure metrics pushed to Pushgateway \\u2502\\n     \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n```\\n\\n## 4. Components and key decisions\\n\\n| Component | Choice | Why |\\n|---|---|---|\\n| Model | `gpt-5-mini`, SKU `GlobalStandard` | Cost-efficient, token-based billing. The originally planned `gpt-4o-mini` (SKU `Standard`) was rejected by Azure mid-project \\u2014 see `ai-agent-troubleshooting.md`, issue #7 |\\n| Foundry auth | Azure AD only (`local_auth_enabled = false`) | Consistent with the rest of the project (ACR, Key Vault) \\u2014 no static API keys |\\n| Kubernetes MCP | `containers/kubernetes_mcp_server` (note: underscore in the real image repo, not a hyphen) | Actively maintained, configurable strict read-only mode, explicit denial of `Secret` resources |\\n| Prometheus MCP | `pab1it0/prometheus-mcp-server` (pinned version, HTTP transport enabled via env vars) | Read-only by design |\\n| MCP exposure | NGINX Ingress + Basic Auth + Let's Encrypt (production) | Foundry is a managed service outside the cluster VNet; public authenticated endpoint was the pragmatic choice over VNet injection for a portfolio project |\\n| Knowledge Base | Azure Blob Storage \\u2192 Azure AI Search (indexer/index) \\u2192 Search-based Knowledge Base \\u2192 MCP connection into the Foundry Project | Chosen over the basic File Search setup originally planned, for a fully passwordless, RBAC-based retrieval pipeline (see \\u00a75) |\\n| AI Security Review | Direct REST call from a dedicated CI job, not a persistent MCP tool | Security reports are generated once per pipeline run; a dedicated always-on MCP server would be disproportionate |\\n| Observability of the agent | Prometheus Pushgateway | A CI job is ephemeral; Prometheus scrapes in pull mode, so the Pushgateway bridges the gap |\\n\\n## 5. Knowledge Base (RAG) \\u2014 as actually built\\n\\nRather than the basic Foundry File Search originally planned, the\\nKnowledge Base was built as a fully-managed, passwordless retrieval\\npipeline:\\n\\n```\\nGit repo (agent-knowledge.md, troubleshooting.md, CI config,\\nTerraform, K8s manifests, Kyverno policies)\\n        \\u2502  upload\\n        \\u25bc\\nAzure Blob Storage (stfhajarazuredev / knowledge-documents)\\n        \\u2502  data source: hajar-index-datasource\\n        \\u25bc\\nAzure AI Search\\n        \\u2502  indexer: hajar-index-indexer\\n        \\u25bc\\nIndex: hajar-index (365 documents, ~16.7 MB)\\n        \\u2502\\n        \\u25bc\\nKnowledge Base: \\\"knowledgebase\\\"\\n        \\u2502  MCP endpoint:\\n        \\u2502  https://<search-service>.search.windows.net/knowledgebases/knowledgebase/mcp\\n        \\u25bc\\nFoundry Project connection: kb-knowledgebase-qfyjx\\n  - category: RemoteTool\\n  - authType: ProjectManagedIdentity\\n  - audience: https://search.azure.com/\\n        \\u25bc\\nAgent: k8s-incident-investigator\\n```\\n\\n**Identities and RBAC involved:**\\n- Azure AI Search uses a **System Assigned Managed Identity** with\\n  `Storage Blob Data Reader` on the storage account and\\n  `Cognitive Services OpenAI User` on the Foundry resource (needed for\\n  the indexer's enrichment skills).\\n- The Foundry **Project's own managed identity** holds\\n  `Search Index Data Reader` on the Azure AI Search service \\u2014 this is\\n  what lets the agent query the Knowledge Base without any API key.\\n- Azure AI Search has `disableLocalAuth: true` \\u2014 no API key access at\\n  all; everything goes through Microsoft Entra ID + RBAC.\\n\\n**Validation performed:**\\n- Indexer run: `status: success, processed: 1, failed: 0`.\\n- Direct `GET /indexes` against the Search service with Entra ID auth\\n  returned `200`.\\n- `GET` on the Knowledge Base MCP endpoint returned `405 Allow: POST`\\n  \\u2014 expected, confirms the endpoint is reachable and enforces the MCP\\n  protocol correctly.\\n- Grounding test: asked the agent about a specific troubleshooting\\n  entry (the `westeurope` region rejection encountered during initial\\n  Terraform provisioning \\u2014 see `ai-agent-troubleshooting.md`, issue #1);\\n  the agent correctly retrieved the exact symptom\\n  (`RequestDisallowedByAzure`) and the fix (switching to\\n  `francecentral`) from `troubleshooting.md`, proving the retrieval\\n  chain works end-to-end rather than falling back to generic model\\n  knowledge.\\n\\n## 6. Troubleshooting log\\n\\nEvery real incident encountered while building this agent \\u2014 model\\ndeprecation, quota limits, RBAC gaps, TLS/networking issues, CI\\nauthentication failures, and more \\u2014 is documented separately in\\n[`ai-agent/docs/ai-agent-troubleshooting.md`](ai-agent-troubleshooting.md), in the order it\\noccurred. Kept out of this file so architecture and incident history\\nstay independently readable.\\n\\n## 7. Validated real-world result: readiness probe investigation\\n\\nAs a live test (not a scripted demo), the Deployment's readiness probe\\npath was intentionally broken (`/actuator/health/readyz` instead of\\nthe real `/actuator/health/readiness`) while ArgoCD's `self-heal` was\\ntemporarily disabled. Asked to investigate, the agent independently:\\n\\n- Listed pods, fetched pod details, cluster events, the Deployment\\n  spec, application logs, the Service definition, and the HPA state \\u2014\\n  six different tool calls, each cited individually as evidence.\\n- Correctly identified the exact one-character discrepancy\\n  (`readyz` vs. `readiness`) between the probe configuration and the\\n  application's real Spring Boot Actuator endpoint.\\n- Cross-referenced a live Prometheus query\\n  (`kube_pod_container_status_ready`) confirming the container's\\n  unready state, rather than relying on Kubernetes state alone.\\n- Correctly scoped the blast radius (single replica \\u2192 total dev\\n  outage; HPA unable to compute CPU-based scaling metrics with no\\n  Ready pods).\\n- Proposed a fix without executing it, in line with its\\n  diagnose-only mandate \\u2014 including a secondary option (exposing a\\n  `/readyz` alias in the app instead of just fixing the probe path).\\n\\nThis is the strongest evidence in the project that the agent performs\\ngenuine multi-source correlation rather than pattern-matching a single\\nsignal.\\n\\n## 8. AI Security Review \\u2014 pipeline integration\\n\\n```yaml\\nstages:\\n  - test\\n  - build\\n  - scan\\n  - push\\n  - sign\\n  - ai_review\\n  - deploy\\n```\\n\\nThe `ai_security_review` job:\\n- Depends on `container_scan`, `sast`, and `sign_and_sbom` artifacts.\\n- Authenticates via its own OIDC-federated identity\\n  (`AI_REVIEW_CLIENT_ID`), fully separate from the ACR pipeline\\n  identity \\u2014 least privilege between unrelated workflows.\\n- Performs the token exchange, calls the Foundry agent's Responses\\n  API, and writes `ai-security-report.md` as a pipeline artifact\\n  (`when: always`, so the report survives even when the scan itself\\n  fails a job).\\n- Pushes success/failure and duration metrics to the Prometheus\\n  Pushgateway, visible in Grafana (see \\u00a79).\\n\\n`container_scan` currently reports but does not hard-block the\\npipeline on findings (`|| true` on the Trivy exit-code check). This is\\na **deliberate, temporary exception, not a security regression**, and\\nit concerns a different image/vulnerability than the one already\\nresolved earlier in the project: in `devsecops-troubleshooting.md`\\n(issue #10), the gate correctly blocked the pipeline on an OS-level\\n(Alpine) vulnerability, and that image was fixed and rescanned until\\nit passed \\u2014 the gate itself was never weakened there. Here, on a\\nseparate application dependency, a real, unresolved CVE was found\\n(the Tomcat vulnerability analyzed in `ai-agent-troubleshooting.md`,\\nissue #17.4) and the `|| true` was added specifically so this finding\\ncould reach the AI Security Review job as an actual test case for the\\nagent, instead of being blocked before the agent ever saw it.\\n**This should be reverted to a real blocking gate (remove `|| true`)\\nonce the agent's diagnostic capability on a live vulnerability has\\nbeen demonstrated** \\u2014 leaving it silently disabled beyond that point\\nwould undermine the project's own security narrative.\\n\\n## 9. Observability of the agent (Prometheus + Grafana)\\n\\nA CI job is ephemeral and Prometheus scrapes in pull mode, so a\\nPushgateway bridges the two: `ai_security_review` pushes a metric on\\nevery run, whether it succeeds or fails.\\n\\n**Metrics exposed:**\\n```\\nai_agent_call_total{status=\\\"success\\\"|\\\"failure\\\"}\\nai_agent_call_duration_seconds\\n```\\n\\n**Pipeline:** `Pushgateway (namespace ai-agent, monitoring node pool)`\\n\\u2192 scraped by Prometheus via a `ServiceMonitor` (label matched to the\\n`kube-prometheus-stack` release name \\u2014 verify this against\\n`kubectl get servicemonitor -n monitoring` rather than assuming a\\ngeneric value, it caused a false negative during setup) \\u2192 visualized\\nin Grafana.\\n\\n**Grafana panels**, added to the project's existing dashboard:\\n```promql\\nsum by (status) (ai_agent_call_total)       # request rate by status\\navg(ai_agent_call_duration_seconds)          # p-average latency\\n```\\n\\n**Dashboard-as-code:** the dashboard is no longer imported manually\\nthrough the Grafana UI (which does not survive a Grafana pod restart\\nor a cluster rebuild \\u2014 manually imported dashboards live only in\\nGrafana's internal SQLite storage). It is now defined as a\\n`ConfigMap` labeled `grafana_dashboard: \\\"1\\\"` in\\n`k8s/base/ai-agent/grafana-dashboard-configmap.yaml`, picked up\\nautomatically by the `kube-prometheus-stack` Grafana sidecar. This\\nmakes the dashboard fully reproducible: it reappears automatically\\nafter any `terraform destroy` + `apply` cycle, with no manual import\\nstep \\u2014 confirmed working, including the agent-specific panels above.\\n\\n**Known limitation:** only CI-triggered calls are observed; the\\nFoundry portal's interactive chat usage is not (see \\u00a710). And the\\nBasic Auth credential shared by the Ingress now has to stay in sync\\nacross four separate places \\u2014 the Kubernetes secret, the\\n`PUSHGATEWAY_AUTH` GitLab CI/CD variable, and the `Authorization`\\nheader configured on **both** Foundry MCP tools\\n(`kubernetes-cluster` and `prometheus-metrics`). Rotating it in only\\none location silently breaks the others with a `401` \\u2014 this was hit\\nin practice (see `ai-agent-troubleshooting.md`, issue #22) and is a\\nlegitimate argument for a per-consumer credential or a managed secret\\nrotation setup as a future improvement, not a one-off mistake to just\\navoid repeating.\\n\\n## 10. What the agent explicitly does NOT do\\n\\n- No write actions on the cluster, ever \\u2014 diagnosis only.\\n- No Azure Monitor / Log Analytics integration \\u2014 Prometheus already\\n  covers metrics; adding it was judged unnecessary cost/complexity.\\n- No private networking (VNet injection) between Foundry and the MCP\\n  servers \\u2014 a publicly exposed, authenticated Ingress was used\\n  instead, a deliberate trade-off for a portfolio-scale project.\\n- No observability of interactive chat usage in the Foundry portal \\u2014\\n  only CI-triggered calls are currently monitored (\\u00a79); full coverage\\n  would require Application Insights.\\n- The Foundry Project and Agent themselves are not Terraform-managed\\n  \\u2014 only the underlying Cognitive Services account and model\\n  deployment are; the Project/Agent were created via the Azure\\n  portal, a current limitation of the `azurerm` provider on this\\n  resource model.\\n\\n## 11. Roadmap\\n\\n- Human-in-the-loop: agent proposes a fix, a human approves, a\\n  commit/PR is generated automatically.\\n- Full Azure Monitor / Log Analytics integration.\\n- VNet injection for private connectivity between Foundry and AKS.\\n- Full agent observability, including interactive portal usage, via\\n  Application Insights.\\n- Expand coverage to a `staging` namespace.\\n- Revert the temporary Trivy `|| true` exception noted in \\u00a78 to a real\\n  blocking gate.\\n\\n\\n---\\n\\n\\n# Troubleshooting \\u2014 AI Agent (Knowledge Base, Infrastructure & CI/CD)\\n\\nThis document brings together all real incidents encountered while building the AI incident investigation agent, in chronological order of resolution. It is intentionally kept separate from the architecture README so that both documents remain independently readable.\\n\\nTwo parts:\\n\\n- **Part 1**: Azure AI Search, Knowledge Base & Foundry\\n- **Part 2**: Model, network/cluster infrastructure & CI/CD pipeline\\n\\n---\\n\\n# PART 1 \\u2014 Azure AI Search, Knowledge Base & Foundry\\n\\n## 1. Terraform \\u2014 Azure region unavailable\\n\\nSame regional restriction already documented on the main platform project (`devsecops-troubleshooting.md`, issue #1): `westeurope` was rejecting new customers on this subscription. Fixed the same way \\u2014 switched the region to `francecentral` \\u2014 and provisioning continued normally. Not repeated in full detail here since the root cause and fix are identical.\\n\\n---\\n\\n## 2. Azure AI Search \\u2014 API key authentication rejected\\n\\n**Symptom**: `api-key: <key>` returned `HTTP 401 Unauthorized`, even after regenerating the key.\\n\\n**Diagnosis**: The service had `disableLocalAuth: true` \\u2014 API key authentication was structurally disabled, regardless of whether the key itself was valid.\\n\\n**Fix**: Switched to Microsoft Entra ID token authentication:\\n\\n```bash\\nTOKEN=$(az account get-access-token \\\\\\n  --scope \\\"https://search.azure.com/.default\\\" \\\\\\n  --query accessToken -o tsv)\\n```\\n\\nSuccessfully tested with `HTTP 200` against `/indexes`.\\n\\n---\\n\\n## 3. RBAC \\u2014 Managed identity permissions across Search, Storage & Foundry\\n\\n**Context**: Both the indexer and the Knowledge Base needed correctly scoped access, and this required granting roles to two distinct managed identities in turn.\\n\\n**Fixes**:\\n\\n- Granted the Search Service managed identity (`4b062e98-41e2-47a2-aef2-c90f12d35de7`):\\n  - `Storage Blob Data Reader` on `stfhajarazuredev`\\n  - `Cognitive Services OpenAI User` on `aif-hajar-azure-project-dev`\\n- Granted the Foundry project managed identity (`7995e511-da7d-4c9a-a2a6-6500468ef404`):\\n  - `Search Index Data Reader`, scoped specifically to the Azure AI Search resource\\n\\n**Result**: Indexing succeeded (`status: success, processed: 1, failed: 0`), and the Knowledge Base could subsequently query the index.\\n\\n**Verification**:\\n\\n```bash\\naz role assignment list --assignee-object-id \\\"7995e511-...\\\" \\\\\\n  --scope \\\"/subscriptions/.../searchServices/aif-hajar-azure-project-project-srch-6j0l\\\" \\\\\\n  --query \\\"[].{Role:roleDefinitionName,PrincipalId:principalId}\\\" -o table\\n```\\n\\n**Lesson**: verify the exact `principalId` rather than relying only on a resource name \\u2014 the Search Service identity and the Foundry project identity are easy to confuse when assigning RBAC roles.\\n\\n---\\n\\n## 4. Foundry Connection \\u2014 Incorrect initial authentication type\\n\\n**Symptom**: The Foundry connection `kb-knowledgebase-qfyjx` initially used `authType: CustomKeys`, which was incompatible with `disableLocalAuth = true` on Azure AI Search.\\n\\n**Fix**: Reconfigured the connection to use:\\n\\n```text\\nauthType: ProjectManagedIdentity\\naudience: https://search.azure.com/\\n```\\n\\n---\\n\\n## 5. Knowledge Base MCP \\u2014 HTTP 405 (false positive)\\n\\n**Test**: Sent a `GET` request to the Knowledge Base MCP endpoint.\\n\\n**Result**:\\n\\n```text\\nHTTP 405, Allow: POST\\n```\\n\\n**Interpretation**: This was not an authentication problem. The endpoint existed and was functioning; it simply expected a `POST` request. A `405` in this context was therefore a sign that the infrastructure was correctly exposed rather than broken.\\n\\n---\\n\\n## 6. Foundry Agent \\u2014 Model rate limit\\n\\n**Symptom**:\\n\\n```text\\nYour requests to gpt-4.1-mini for gpt-4.1-mini in francecentral\\nhave exceeded rate limit.\\n```\\n\\n**Diagnosis**: The issue was isolated to the `gpt-4.1-mini` model deployment and was unrelated to Azure AI Search, Blob Storage, the index, the Knowledge Base, RBAC, or MCP \\u2014 all of which were functioning correctly.\\n\\n**Fix**: The Foundry agent was switched to `gpt-5-mini` to continue validation and operation.\\n\\n> **Current state:** Terraform still provisions the `gpt-4.1-mini` deployment (`GlobalStandard`), but the Foundry agent currently uses `gpt-5-mini` because the `gpt-4.1-mini` deployment in `francecentral` is saturated/rate-limited. The Terraform deployment and the model currently selected by the Foundry agent are therefore intentionally different.\\n\\n---\\n\\n# PART 2 \\u2014 Model, network/cluster infrastructure & CI/CD\\n\\n## 7. Model deprecation during the project\\n\\n**Symptom**: `terraform apply` failed twice in a row while deploying the Foundry model:\\n\\n1. `SKU 'Standard' not supported in this region` for `gpt-4o-mini`.\\n2. After switching to `GlobalStandard`: `ServiceModelDeprecating`.\\n\\n**Fix**: Performed a read-only verification before trying again:\\n\\n```bash\\naz cognitiveservices model list -l francecentral \\\\\\n  --query \\\"[?model.name=='gpt-4.1-mini'].{version:model.version,skus:model.skus[].name}\\\"\\n```\\n\\nMigrated the Terraform deployment to `gpt-4.1-mini` (`GlobalStandard`, `2025-04-14`), with:\\n\\n```hcl\\nlifecycle {\\n  ignore_changes = [model[0].version]\\n}\\n```\\n\\nThis prevents the same deployment from being blocked by future automatic Microsoft model version updates.\\n\\n> **Important:** This incident documents the historical Terraform migration to `gpt-4.1-mini`. It does not mean that `gpt-4.1-mini` is currently the model used by the Foundry agent. The agent currently uses `gpt-5-mini` due to the rate-limit issue described in incident #6.\\n\\n---\\n\\n## 8. Azure subscription vCPU quota\\n\\n**Symptom**: `ErrCode_InsufficientVCPUQuota` when attempting to add a node to the `system` node pool.\\n\\n**Diagnosis**: The subscription had a regional quota of 4 vCPUs, already fully consumed by the two existing node pools.\\n\\n**Decision**: No quota increase request was made, as this was considered unreliable for the free subscription. Existing capacity was optimized instead (see #9).\\n\\n---\\n\\n## 9. 30 pods/node limit (Azure CNI)\\n\\n**Symptom**: Pods remained `Pending` with `Too many pods`, despite having explicit CPU and memory requests. The same limit later blocked the cert-manager HTTP-01 solver pod (`cm-acme-http-solver-*`), which also stayed `Pending` for the same reason.\\n\\n**Diagnosis**: Azure CNI imposed a limit of 30 pods per node, which was nearly reached by system and platform workloads such as CoreDNS, konnectivity, metrics-server, CSI drivers, the Workload Identity webhook, Kyverno, and ArgoCD.\\n\\n**Fixes**:\\n\\n- Disabled unused ArgoCD components (`dex-server`, `notifications-controller`, `applicationset-controller`) through a version-controlled Kustomize configuration.\\n- Set `strategy.rollingUpdate.maxSurge: 0` on `portfolio-app`.\\n- Scheduled AI agent components, and later the cert-manager solver pod (via `nodeSelector`/`toleration` on `solvers[].http01.ingress.podTemplate` in the `ClusterIssuer`), on the `monitoring` node pool, which had more available capacity, instead of the `system` node pool.\\n\\n---\\n\\n## 10. SecretProviderClass \\u2014 Forgotten placeholder, followed by a false lead\\n\\n**Symptom**: Key Vault secret mounting failed with an unusual HTTP 400 response containing a generic ASP.NET error page.\\n\\n**Diagnosis**: The `objectName` field still literally contained:\\n\\n```text\\n<nom-du-secret-dans-keyvault>\\n```\\n\\nThe placeholder had never been replaced with the actual Key Vault secret name.\\n\\n**False lead corrected during troubleshooting**: An attempt to dynamically resolve the client ID using:\\n\\n```yaml\\nclientID: \\\"${SERVICE_ACCOUNT_CLIENT_ID}\\\"\\n```\\n\\nfailed with:\\n\\n```text\\nAADSTS700016\\n```\\n\\nThis syntax was not supported by the installed CSI driver version. At the time of implementation, this capability was an upstream feature request rather than a delivered feature.\\n\\n**Final fix**: Returned to a literal `clientID` value, which remains stable as long as the managed identity is not recreated.\\n\\n---\\n\\n## 11. Inconsistent ACR authentication\\n\\n**Symptom**: Terraform configured:\\n\\n```hcl\\nadmin_enabled = false\\n```\\n\\nwhile the pipeline still used `ACR_USERNAME` / `ACR_PASSWORD` with `docker login`.\\n\\n**Fix**: Migrated completely to GitLab \\u2192 Microsoft Entra ID OIDC federation:\\n\\n- Dedicated App Registration\\n- Federated Identity Credential scoped to the exact repository and branch\\n- `AcrPush` role scoped only to the ACR\\n- Authentication through:\\n\\n```bash\\naz login --federated-token\\naz acr login\\n```\\n\\nNo stored secret was required.\\n\\n---\\n\\n## 12. Key Vault \\u2014 Incomplete Workload Identity configuration\\n\\nSame Workload Identity mechanism already built and documented in depth on the main platform project, reapplied here to the agent's own Key Vault access: `oidc_issuer_enabled` was active on AKS, but `workload_identity_enabled` was missing, and the `SecretProviderClass` still contained values inherited from the previous infrastructure.\\n\\n**Fix**: completed the configuration (ServiceAccount annotated with the managed identity `clientID`, projected federated token injected by `azure-wi-webhook`, exchanged for an Azure access token through Microsoft Entra ID) \\u2014 removing the last dependency on static credentials for this component.\\n\\n---\\n\\n## 13. Kyverno blocking `:latest` images\\n\\n**Symptom**: The `disallow-latest-tag` policy rejected deployments of the MCP servers.\\n\\n**Additional diagnosis**: One image name was also incorrect:\\n\\n```text\\nkubernetes-mcp-server\\n```\\n\\ninstead of the actual image name:\\n\\n```text\\nkubernetes_mcp_server\\n```\\n\\nwith an underscore.\\n\\n**Fix**:\\n\\n- Retrieved the actual available tags using `skopeo list-tags`\\n- Pinned deployments to real image tags\\n- Corrected the image name\\n\\n---\\n\\n## 14. Prometheus MCP server stuck in stdio mode\\n\\n**Symptom**: The pod repeatedly terminated successfully with:\\n\\n```text\\nCompleted\\n```\\n\\nrather than entering `CrashLoopBackOff`.\\n\\n**Diagnosis**: The default transport mode was `stdio`. The pinned image version (`1.0.4`) did not yet support environment variables for forcing HTTP transport.\\n\\n**Fix**: Updated to a version supporting HTTP transport, after verifying that the required tag actually existed.\\n\\n---\\n\\n## 15. Azure Load Balancer health probe incompatible with NGINX\\n\\n**Symptom**: External traffic timed out, while internal access through the NodePort worked correctly.\\n\\n**Diagnosis**: Azure Load Balancer `DipAvailability` metrics showed approximately 20% successful probes.\\n\\nThe health probe was requesting `/` over HTTP, while NGINX returned `404` on `/` because there was no matching Ingress rule for that path. Azure therefore considered the backend unhealthy.\\n\\n**Fix**: Redirected the health probe to `/healthz` using:\\n\\n```yaml\\nservice.beta.kubernetes.io/azure-load-balancer-health-probe-request-path\\n```\\n\\n---\\n\\n## 16. TLS certificate not associated \\u2014 hostname typo\\n\\n**Symptom**: The TLS handshake continued to serve the default self-signed NGINX certificate, even though a valid Let's Encrypt certificate had already been issued.\\n\\n**Diagnosis**: A manual edit had introduced a mismatch between `spec.rules[].host` and `spec.tls[].hosts` \\u2014 one dot had been replaced with a hyphen. NGINX associates certificates through exact SNI hostname matching, so the mismatch prevented the correct certificate from being selected.\\n\\n**Diagnosis command** (useful in general for isolating SNI/certificate mismatches):\\n\\n```bash\\nopenssl s_client -connect <ip>:443 -servername <host-attendu> </dev/null \\\\\\n  | openssl x509 -noout -issuer\\n```\\n\\n**Fix**: Corrected the hostname inconsistency between the two fields.\\n\\n---\\n\\n## 17. `ai_security_review` job \\u2014 four consecutive failures\\n\\n### 17.1 YAML indentation error\\n\\nAn indentation error in `.gitlab-ci.yml` caused `artifacts.paths` to be incorrectly aligned. This blocked the job before the AI logic itself could run.\\n\\n### 17.2 Incorrect authentication token\\n\\nThe raw GitLab OIDC token was sent directly as a `Bearer token` to Foundry. This was incorrect: the GitLab OIDC token is used to prove identity for a federated exchange; it is not itself the final access token for Foundry.\\n\\n**Fix**: Added an explicit `client_credentials` + `client_assertion` exchange against `login.microsoftonline.com` before calling Foundry.\\n\\n### 17.3 API version drift\\n\\nThe API version `2025-05-01` was rejected with `UnsupportedApiVersion` on `/agents/{name}/endpoint/protocols/openai/responses`. The correct value, confirmed against Microsoft's official example for this specific endpoint, was `api-version=v1`.\\n\\n### 17.4 `context_length_exceeded`\\n\\nThe raw Trivy, SAST, and SBOM reports were sent directly to the model, exceeding its context window.\\n\\n**Fix**:\\n\\n- Trivy reports were filtered to HIGH/CRITICAL vulnerabilities.\\n- SAST and SBOM reports were truncated to essential fields.\\n- The resulting summaries were sent to the agent instead of the complete raw reports.\\n\\n**Result**: Once all four issues were fixed, the pipeline successfully analyzed a real security result:\\n\\n- Three **CRITICAL** CVEs were identified in: `org.apache.tomcat.embed:tomcat-embed-core 10.1.55`\\n- CVEs: `CVE-2026-65182`, `CVE-2026-65905`, `CVE-2026-68525`\\n- Fixed version: `10.1.58`\\n\\nThe findings were automatically transformed into a structured and prioritized report.\\n\\n---\\n\\n## 18. RBAC gaps discovered under real operating conditions\\n\\nThree read-only permissions were missing and were discovered only when the agent actually needed them during an investigation:\\n\\n- `namespaces` \\u2014 cluster-wide listing\\n- `pods.metrics.k8s.io` \\u2014 live metrics\\n- `endpoints` \\u2014 Service routing verification during the investigation of a broken readiness probe\\n\\n**Fix**: Consolidated these permissions into a single broader `Role` / `ClusterRole`, while keeping the entire access surface strictly read-only.\\n\\nThe resulting RBAC policy covers the current read-only surface required for Kubernetes incident diagnosis, avoiding incremental permission discovery during a live demonstration.\\n\\n---\\n\\n## 19. Grafana dashboard lost after every restart/rebuild\\n\\nSame underlying \\\"dashboard as code\\\" fix already applied on the main platform project, reapplied here to the agent's own panels: a dashboard imported through the Grafana UI is stored in Grafana's internal SQLite database and doesn't survive the pod lifecycle.\\n\\n**Fix**: converted the dashboard to a version-controlled `ConfigMap` labelled `grafana_dashboard: \\\"1\\\"`, automatically loaded by the Grafana sidecar. The dashboard, including the agent-specific panels, now survives a full `terraform destroy` / `terraform apply` cycle \\u2014 confirmed through testing.\\n\\n---\\n\\n## 20. `ai_security_review` job never executed \\u2014 chained dependencies\\n\\n**Symptom**: No agent metrics appeared anywhere, with no visible error.\\n\\n**Diagnosis**: The `push_to_acr` job had failed because of a temporary network timeout during `az acr login`. GitLab's chained `needs` dependencies were:\\n\\n```text\\nsign_and_sbom \\u2192 push_to_acr\\nai_security_review \\u2192 sign_and_sbom\\n```\\n\\nTherefore, GitLab never executed a job whose required dependency had failed. `ai_security_review` appeared grey (`skipped`) in the pipeline and had never actually run. This was not a script bug.\\n\\n**Fix**: Simply rerunning the failed `push_to_acr` job allowed the remaining dependency chain to execute normally.\\n\\n---\\n\\n## 21. Metrics push silently failing\\n\\n**Symptom**: The `ai_security_review` job succeeded (`STATUS: 200`, `Report generated successfully`), but no metrics ever appeared in Pushgateway.\\n\\n**Diagnosis**: The `push_metrics` function did not log anything when environment variables were missing and simply returned. It also did not log successful pushes. As a result, a CI job could succeed while the metrics push had silently been skipped, with no evidence showing what had happened.\\n\\n**Fix**: Added explicit logs such as `PUSH METRICS STATUS: ...` to every branch of the function, including both success and failure paths. There is now no silent failure zone in this step.\\n\\n---\\n\\n## 22. Basic Auth password desynchronized after rotation\\n\\n**Symptom**: After regenerating the Ingress Basic Auth password, an external `curl` request to Pushgateway returned `401 Unauthorized`, while internal access through `port-forward` continued to work.\\n\\n**Diagnosis**: The same password was used in four distinct locations that had to remain synchronized:\\n\\n1. Kubernetes secret: `mcp-basic-auth`\\n2. GitLab variable: `PUSHGATEWAY_AUTH`\\n3. Authorization header on the Foundry MCP tool: `kubernetes-cluster`\\n4. Authorization header on the second Foundry MCP tool: `prometheus-metrics`\\n\\nThe password rotation had only been applied to some of these locations.\\n\\n**Fix**: Regenerated the password and propagated the new value to all required locations.\\n\\nVerification:\\n\\n```bash\\nhtpasswd -vb <(kubectl get secret mcp-basic-auth -n ai-agent -o jsonpath='{.data.auth}' | base64 -d) mcp-agent \\\"<mot-de-passe>\\\"\\n```\\n\\n**Side effect discovered afterwards**: Once Pushgateway authentication was resynchronized, the agent itself started returning `401 Unauthorized` when accessing its Kubernetes MCP tool \\u2014 same cause: the Authorization header configured for the Foundry tool still contained the old password. The header was updated for both Foundry tools.\\n\\n**Known limitation / roadmap item**: The shared static Basic Auth credential currently exists in four different locations and has no automated rotation mechanism. A stronger long-term design would use dedicated credentials per consumer or a managed secret rotation mechanism rather than relying on manual synchronization after every password rotation.\\n\\n---\\n\\n# Consolidated Final State\\n\\n| Component | Status |\\n|---|---|\\n| Blob Storage / Data Source / Indexer / Index (365 documents) | \\u2705 |\\n| Knowledge Base + MCP connection (ProjectManagedIdentity) | \\u2705 |\\n| Foundry Agent (`gpt-5-mini`) | \\u2705 |\\n| Kubernetes & Prometheus MCP servers (read-only RBAC) | \\u2705 |\\n| Ingress + Let's Encrypt TLS (production) | \\u2705 |\\n| ACR authentication (OIDC, zero secrets) | \\u2705 |\\n| Key Vault (Workload Identity) | \\u2705 |\\n| CI `ai_security_review` job (dedicated identity, report summarization) | \\u2705 |\\n| Agent observability (Pushgateway \\u2192 Prometheus \\u2192 Grafana) | \\u2705 |\\n| Persistent Grafana dashboard (ConfigMap as code) | \\u2705 |\\n| Readiness probe demonstration scenario (multi-source investigation) | \\u2705 |\\n\\n> **Model note:** `gpt-4.1-mini` remains provisioned through Terraform as a `GlobalStandard` deployment, but the Foundry agent currently uses `gpt-5-mini` because the `gpt-4.1-mini` deployment in `francecentral` is rate-limited.\\n\\n---\\n\\n# Lessons Learned\\n\\n1. **A Terraform error can originate from an Azure platform restriction**, not necessarily from a configuration mistake. Check regions, quotas, and policies before looking for a syntax or code-level problem.\\n\\n2. **`disableLocalAuth=true` requires an Entra ID / RBAC architecture end to end.** API keys are no longer an option; this is not simply a matter of following a security best practice.\\n\\n3. **Always verify the exact `principalId`**, rather than relying only on a resource name, before assigning an RBAC role. Different managed identities \\u2014 such as the Search Service identity and the Foundry project identity \\u2014 are easy to confuse.\\n\\n4. **An unexpected HTTP status code is not always a failure.** A `405` on an MCP endpoint can indicate that the endpoint exists and is correctly exposed but that the wrong HTTP method was used.\\n\\n5. **Separate diagnostic layers.** Model rate limits, subscription vCPU quotas, and per-node pod limits are completely independent Azure constraints that can produce superficially similar symptoms (\\\"it doesn't work\\\"). Isolating the affected layer before applying a fix prevents changing the wrong component.\\n\\n6. **Never rely on unverified syntax, even when similar syntax is documented elsewhere.** The `${SERVICE_ACCOUNT_CLIENT_ID}` attempt in #10 and the Foundry API version changes in #17 demonstrate that a read-only verification before applying a change is cheaper than repeated failed deployments.\\n\\n7. **A successful CI job does not prove that every internal step actually succeeded.** A silent `return` on partial failure can hide a problem across multiple pipeline runs. Every critical branch should log its result explicitly, including successful execution.\\n\\n8. **A shared secret across multiple consumers creates a synchronization risk rather than simplifying security.** Every rotation must be propagated to every location where the credential is used, or replaced with dedicated credentials per consumer whenever reasonably possible.\\n\\n9. **Keep infrastructure state and application configuration conceptually separate.** Terraform can provision a model deployment while the Foundry agent may use a different deployment. The documentation should clearly distinguish what is infrastructure-managed from what is currently selected at the application/agent level.\\n\\n10. **Version-control operational configuration whenever possible.** Dashboards, policies, routing configuration, and Kubernetes resources should be represented as code so that rebuilding the environment does not require undocumented manual steps.\\n\\n\\n---\\n\\n\\n# KubeSentry \\u2014 Agentic AIOps & GitOps Platform on Azure\\n\\nA production-style Kubernetes platform built on Azure (AKS), designed around a **security-by-design** and **GitOps-first** philosophy rather than bolted-on tooling. This project covers the full lifecycle of a cloud-native application: infrastructure provisioning, secure CI/CD, continuous deployment, runtime security enforcement, autoscaling, and real-time observability with alerting.\\n\\n> This repository is mirrored to GitHub for visibility. The active CI/CD pipeline (GitLab CI) and GitOps deployment (ArgoCD) run against the source repo on GitLab \\u2014 this mirror is a snapshot of the code and documentation, not a second live deployment.\\n\\n> Real debugging log for this project (issues encountered, root causes, fixes): [`docs/devsecops-troubleshooting.md`](devsecops-troubleshooting.md)\\n\\n---\\n\\n## Table of Contents\\n\\n- [Architecture Overview](#architecture-overview)\\n- [Tech Stack](#tech-stack)\\n- [1. Infrastructure as Code (Terraform)](#1-infrastructure-as-code-terraform)\\n- [2. Secure CI/CD Pipeline](#2-secure-cicd-pipeline)\\n- [3. GitOps with ArgoCD](#3-gitops-with-argocd)\\n- [4. Runtime Security (Defense in Depth)](#4-runtime-security-defense-in-depth)\\n- [5. Secrets Management & Microsoft Entra Workload Identity](#5-Secrets-Management-&-Microsoft-Entra-Workload-Identity)\\n- [6. Autoscaling](#6-autoscaling)\\n- [7. Observability & Alerting](#7-observability--alerting)\\n- [Repository Structure](#repository-structure)\\n- [Getting Started](#getting-started)\\n- [Cost Management](#cost-management)\\n- [Roadmap](#roadmap)\\n\\n---\\n\\n## Cluster Overview\\n\\n```text\\n\\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510     \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510     \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n\\u2502  Terraform  \\u2502\\u2500\\u2500\\u2500\\u2500\\u25b6\\u2502  Azure (AKS, \\u2502\\u2500\\u2500\\u2500\\u2500\\u25b6\\u2502    ArgoCD     \\u2502\\n\\u2502  (IaC)      \\u2502     \\u2502  ACR, Vault) \\u2502     \\u2502 (Application) \\u2502\\n\\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518     \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518     \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n                                                 \\u2502 sync (dev)\\n                                                 \\u25bc\\n                                  \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n                                  \\u2502        AKS Cluster           \\u2502\\n                                  \\u2502  node pool \\\"system\\\"          \\u2502\\n                                  \\u2502  \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510  \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510  \\u2502\\n                                  \\u2502  \\u2502 App Pods   \\u2502  \\u2502  HPA   \\u2502  \\u2502\\n                                  \\u2502  \\u2502 (Kyverno,  \\u2502\\u25c0\\u2500\\u2524 scales \\u2502  \\u2502\\n                                  \\u2502  \\u2502 NetworkPol)\\u2502  \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518  \\u2502\\n                                  \\u2502  \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518              \\u2502\\n                                  \\u2502        \\u2502 scrape              \\u2502\\n                                  \\u2502  node pool \\\"monitoring\\\"      \\u2502\\n                                  \\u2502        \\u2502                     \\u2502\\n                                  \\u2502  \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u25bc\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510  (dedicated,\\u2502\\n                                  \\u2502  \\u2502 Prometheus  \\u2502   tainted)  \\u2502\\n                                  \\u2502  \\u2502  Grafana    \\u2502             \\u2502\\n                                  \\u2502  \\u2502 Alertmanager\\u2502             \\u2502\\n                                  \\u2502  \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518             \\u2502\\n                                  \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n\\nCI: GitLab CI \\u2192 SAST + Unit test \\u2192 Build \\u2192 Trivy scan \\u2192 Push to ACR \\u2192 Image signing + SBOM \\u2192 AI Security Review \\u2192 Update manifest (GitOps)\\n```\\n\\n## Architecture Overview\\n\\n![Architecture Overview](architecture/architecture_devsecops.png)\\n\\n```text\\n\\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n\\u2502      GitLab CI       \\u2502\\n\\u2502                      \\u2502\\n\\u2502 Unit Tests           \\u2502\\n\\u2502 SAST                 \\u2502\\n\\u2502 Trivy                \\u2502\\n\\u2502 Cosign + SBOM        \\u2502\\n\\u2502 Update Manifest      \\u2502\\n\\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n           \\u2502\\n           \\u2502 Build / Scan / Sign\\n           \\u25bc\\n\\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n\\u2502   Azure Container    \\u2502\\n\\u2502      Registry        \\u2502\\n\\u2502        (ACR)         \\u2502\\n\\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n           \\u2502\\n           \\u2502 Image\\n           \\u25bc\\n\\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n\\u2502                         Azure                              \\u2502\\n\\u2502                                                            \\u2502\\n\\u2502  \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510       \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510   \\u2502\\n\\u2502  \\u2502    Terraform     \\u2502\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u25b6\\u2502     Azure Resources      \\u2502   \\u2502\\n\\u2502  \\u2502       IaC        \\u2502       \\u2502                          \\u2502   \\u2502\\n\\u2502  \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518       \\u2502 AKS / ACR / Key Vault    \\u2502   \\u2502\\n\\u2502                             \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518   \\u2502\\n\\u2502                                          \\u2502                 \\u2502\\n\\u2502                                          \\u25bc                 \\u2502\\n\\u2502  \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510  \\u2502\\n\\u2502  \\u2502                    AKS Cluster                       \\u2502  \\u2502\\n\\u2502  \\u2502                                                      \\u2502  \\u2502\\n\\u2502  \\u2502  \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510                            \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502       ArgoCD         \\u2502                            \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502                      \\u2502                            \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502 GitOps reconciliation\\u2502                            \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518                            \\u2502  \\u2502\\n\\u2502  \\u2502             \\u2502 sync                                   \\u2502  \\u2502\\n\\u2502  \\u2502             \\u25bc                                        \\u2502  \\u2502\\n\\u2502  \\u2502  \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502              Application Pod                 \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502                                              \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502 Spring Boot                                  \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502 ServiceAccount                               \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502 HPA                                          \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518    \\u2502  \\u2502\\n\\u2502  \\u2502             \\u2502                                        \\u2502  \\u2502\\n\\u2502  \\u2502             \\u2502 Federated identity                     \\u2502  \\u2502\\n\\u2502  \\u2502             \\u25bc                                        \\u2502  \\u2502\\n\\u2502  \\u2502  \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502       Microsoft Entra Workload Identity      \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502              + AKS OIDC Issuer               \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518    \\u2502  \\u2502\\n\\u2502  \\u2502             \\u2502                                        \\u2502  \\u2502\\n\\u2502  \\u2502             \\u25bc                                        \\u2502  \\u2502\\n\\u2502  \\u2502  \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502       User Assigned Managed Identity         \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502                    (UAMI)                    \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518    \\u2502  \\u2502\\n\\u2502  \\u2502             \\u2502                                        \\u2502  \\u2502\\n\\u2502  \\u2502             \\u2502 Azure RBAC                             \\u2502  \\u2502\\n\\u2502  \\u2502             \\u2502 Key Vault Secrets User                 \\u2502  \\u2502\\n\\u2502  \\u2502             \\u25bc                                        \\u2502  \\u2502\\n\\u2502  \\u2502  \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502               Azure Key Vault                \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502                                              \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502          Application secrets                 \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518    \\u2502  \\u2502\\n\\u2502  \\u2502             \\u2502                                        \\u2502  \\u2502\\n\\u2502  \\u2502             \\u2502 Secret retrieval                       \\u2502  \\u2502\\n\\u2502  \\u2502             \\u25bc                                        \\u2502  \\u2502\\n\\u2502  \\u2502  \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502          Secrets Store CSI Driver            \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502           + Azure Key Vault Provider         \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518    \\u2502  \\u2502\\n\\u2502  \\u2502                                                      \\u2502  \\u2502\\n\\u2502  \\u2502  \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502          Monitoring Node Pool                \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502              (dedicated)                     \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502                                              \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502  Prometheus \\u2502 Grafana \\u2502 Alertmanager         \\u2502    \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518    \\u2502  \\u2502\\n\\u2502  \\u2502                                                      \\u2502  \\u2502\\n\\u2502  \\u2502  Runtime Security:                                   \\u2502  \\u2502\\n\\u2502  \\u2502  \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510       \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510     \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502   Kyverno    \\u2502       \\u2502   Network Policies   \\u2502     \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502 Policy-as-   \\u2502       \\u2502    Default-Deny      \\u2502     \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2502    Code      \\u2502       \\u2502      + Allow Rules   \\u2502     \\u2502  \\u2502\\n\\u2502  \\u2502  \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518       \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518     \\u2502  \\u2502\\n\\u2502  \\u2502                                                      \\u2502  \\u2502\\n\\u2502  \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518  \\u2502\\n\\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n```\\n\\nGitOps Flow\\n\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\n```text\\nGitLab CI\\n    \\u2502\\n    \\u2502 Update Kubernetes image tag\\n    \\u25bc\\nGit Repository\\n    \\u2502\\n    \\u2502 Pull / Reconcile\\n    \\u25bc\\nArgoCD\\n    \\u2502\\n    \\u2502 Apply desired state\\n    \\u25bc\\nAKS\\n```\\n\\nIdentity & Secrets Flow\\n\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\n```text\\n                    AZURE\\n                      \\u2502\\n        \\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2534\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n        \\u2502                           \\u2502\\n       ACR                       Key Vault\\n        \\u25b2                           \\u25b2\\n        \\u2502 AcrPull                   \\u2502 Key Vault Secrets User\\n        \\u2502                           \\u2502\\nAKS kubelet identity          UAMI / Workload Identity\\n                                    \\u25b2\\n                                    \\u2502\\n                             Entra ID Federation\\n                                    \\u25b2\\n                                    \\u2502\\n                              AKS OIDC Issuer\\n                                    \\u25b2\\n                                    \\u2502\\n                            Kubernetes Service Account\\n                                    \\u25b2\\n                                    \\u2502\\n                             Application Pod\\n```\\n\\nObservability Flow\\n\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\n```text\\nApplication\\n      \\u2502\\n      \\u2502 /actuator/prometheus\\n      \\u25bc\\nPrometheus\\n      \\u2502\\n      \\u251c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u25ba Grafana\\n      \\u2502\\n      \\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u25ba Alertmanager\\n                              \\u2502\\n                              \\u25bc\\n                           Alerts\\n```\\n\\nThe platform is organized around three complementary flows:\\n\\n**1. CI/CD and GitOps**\\n\\nGitLab CI performs testing, security scanning, image signing, SBOM generation, and pushes the validated image to Azure Container Registry. The pipeline then updates the Kubernetes image reference in Git. ArgoCD continuously reconciles the Git repository with the AKS cluster and applies the desired state.\\n\\nThe pipeline therefore **does not deploy directly to Kubernetes**. ArgoCD is responsible for cluster-side deployment and reconciliation.\\n\\n**2. Identity and Secrets**\\n\\nApplication workloads authenticate to Azure without storing Azure credentials in the container or Kubernetes manifests. A Kubernetes ServiceAccount is federated through the AKS OIDC issuer and Microsoft Entra Workload Identity to a dedicated User Assigned Managed Identity. Azure RBAC grants that identity the required Key Vault permissions, while the Secrets Store CSI Driver retrieves the secrets at runtime.\\n\\n**3. Observability**\\n\\nThe application exposes JVM and HTTP metrics through Spring Boot Actuator. Prometheus collects these metrics through a Kubernetes `ServiceMonitor`, Grafana provides dashboards, and Alertmanager evaluates and routes alerts based on Prometheus rules.\\n\\nThis architecture combines **Infrastructure as Code, secure CI/CD, GitOps, workload identity, centralized secrets management, runtime security, autoscaling, and observability** into a single Kubernetes platform.\\n\\nThe pipeline never deploys directly to the cluster. It builds, scans, signs, and pushes an image, then updates a Kubernetes manifest in Git \\u2014 **ArgoCD is the only component with write access to the cluster**, pulling the desired state from Git. This split between a *push-based CI* and a *pull-based CD* is the defining principle of GitOps, and it's a deliberate architectural choice here, not a default.\\n\\nCurrently a single ArgoCD `Application` is wired for the `dev` environment (see [Roadmap](#roadmap) for extending this to `staging` / multi-environment).\\n\\n---\\n\\n## Tech Stack\\n\\n| Layer | Tools |\\n|---|---|\\n| Infrastructure as Code | Terraform (AKS, ACR, Key Vault, dedicated monitoring node pool, remote state backend) |\\n| CI/CD | GitLab CI |\\n| Container Registry | Azure Container Registry (ACR) |\\n| GitOps / CD | ArgoCD |\\n| Security \\u2014 pipeline | SAST, Trivy (image vulnerability scanning, blocking), Cosign image signing + SBOM (Syft) |\\n| Security \\u2014 runtime | Kyverno (policy-as-code, enforce mode), Network Policies (default-deny) |\\n| Identity & Secrets | Microsoft Entra Workload Identity, AKS OIDC issuer, User Assigned Managed Identity, Azure Key Vault, Secrets Store CSI Driver, Azure RBAC |\\n| Autoscaling | Horizontal Pod Autoscaler (HPA) |\\n| Observability | Prometheus (kube-prometheus-stack), Grafana, Alertmanager, Micrometer |\\n| Application | Spring Boot (Java 21), Spring Boot Actuator |\\n\\n---\\n\\n## 1. Infrastructure as Code (Terraform)\\n\\nThe entire Azure footprint is provisioned declaratively rather than clicked together manually:\\n\\n- **`main.tf` / `providers.tf`** \\u2014 Azure provider configuration and resource group definition.\\n- **`aks.tf`** \\u2014 AKS cluster definition: default node pool sizing, Kubernetes version, networking mode, OIDC issuer, Microsoft Entra Workload Identity, and Key Vault Secrets Provider integration.\\n- **`acr.tf`** \\u2014 Azure Container Registry, admin account disabled, with role assignments scoped to the AKS managed identity (no static credentials needed to pull images).\\n- **`keyvault.tf`** \\u2014 Azure Key Vault, User Assigned Managed Identity, and Azure RBAC role assignments used for workload-level secret access.\\n- **`monitoring-node-pool.tf`** \\u2014 a **dedicated, tainted node pool** for the observability stack (Prometheus, Grafana, Alertmanager), isolated from the application node pool. This separation matters in practice: without it, the monitoring stack and the application compete for the same CPU/memory budget, which becomes a real scheduling bottleneck on small clusters (see troubleshooting log, issue #13).\\n- **`providers.tf` (backend block)** + **`scripts/bootstrap-backend.sh`** \\u2014 remote state configuration. Terraform state is stored remotely in Azure Storage (not locally), so state is shared safely and isn't lost/corrupted between machines \\u2014 the bootstrap script provisions the storage backend itself before the main configuration can run.\\n- **`outputs.tf` / `variables.tf`** \\u2014 parameterization for multi-environment reuse (dev/staging) without duplicating the configuration.\\n\\n**Why it matters technically**: Terraform computes a diff between desired and actual state on every `plan`/`apply`, making infrastructure changes reviewable and reproducible across environments, avoiding the configuration drift manual provisioning inevitably introduces.\\n\\n---\\n\\n## 2. Secure CI/CD Pipeline\\n\\nEvery push to `master` triggers a `.gitlab-ci.yml` pipeline that enforces security **before** an image is allowed to exist in the registry, not after:\\n\\n1. **Unit tests** (Maven).\\n2. **Static Application Security Testing (SAST)** \\u2014 GitLab's built-in template scans source code before a container is even built.\\n3. **Trivy image scan** \\u2014 scans every OS package and application dependency layer of the built image against CVE databases, configured to **fail the build** (`--exit-code 1`) above HIGH/CRITICAL severity \\u2014 a vulnerable image cannot physically reach the registry.\\n4. **Push to ACR**.\\n5. **Image signing + SBOM** \\u2014 the image is cryptographically signed with Cosign (keyless, via GitLab's OIDC identity), and a Software Bill of Materials is generated with Syft and attached as an attestation. This closes the loop between \\\"the pipeline scanned it\\\" and \\\"the image's provenance is verifiable.\\\"\\n6. **Manifest update** \\u2014 the pipeline's final job updates the image tag in `k8s/overlays/dev` and commits it back to the repo (`[skip ci]` to avoid a pipeline loop) \\u2014 this Git commit is what actually triggers deployment, via ArgoCD, not the pipeline itself.\\n\\nThis is **shift-left security**: checks happen at the earliest possible stage (commit/build time) instead of being discovered in production.\\n\\n---\\n\\n## 3. GitOps with ArgoCD\\n\\nGit is the single source of truth for the cluster's desired state. ArgoCD continuously **reconciles** \\u2014 it compares what's declared in Git against what's actually running, and automatically corrects drift (`selfHeal: true`) and removes resources no longer declared (`prune: true`).\\n\\n**Practical benefits demonstrated in this project**:\\n- **Rollback = `git revert`** \\u2014 Git history *is* the deployment history, no need to track previous `kubectl` state manually.\\n- **Full auditability** \\u2014 every deployment is a commit with an author, timestamp, and diff.\\n- **No cluster credentials in CI** \\u2014 the pipeline only ever writes to Git; ArgoCD, running inside the cluster, does the actual pulling and applying. A compromised CI pipeline still can't touch the cluster directly.\\n- **Environment structure via Kustomize overlays** (`k8s/base` + `k8s/overlays/dev|staging`) \\u2014 shared base manifests, environment-specific patches (replica count, image tag, namespace) layered on top without duplicating the whole manifest per environment. `staging` currently exists as an overlay but is not yet wired to its own ArgoCD `Application` (see [Roadmap](#roadmap)).\\n\\n---\\n\\n## 4. Runtime Security (Defense in Depth)\\n\\nIndependent layers enforce constraints at runtime, so no single misconfiguration compromises the whole cluster:\\n\\n**Kyverno (`k8s/security/kyverno/`)**, enforced (not just audited):\\n- `disallow-root-user.yaml` \\u2014 rejects any pod that doesn't run as a non-root, **numeric** UID at admission time (see troubleshooting issue #8 for why \\\"numeric\\\" specifically matters).\\n- `disallow-latest-tag.yaml` \\u2014 rejects any pod referencing an image tagged `:latest`, forcing every deployment to reference an immutable, traceable tag (a Git commit SHA, set automatically by the CI pipeline).\\n\\n**Network Policies (`k8s/security/network-policies/`)** \\u2014 a zero-trust networking model, built in explicit layers:\\n- `default-deny-all.yaml` \\u2014 the foundation: no traffic is allowed by default, in or out, for any pod in the `dev` namespace.\\n- `allow-dns.yaml` \\u2014 without this, `default-deny-all` also blocks DNS resolution to CoreDNS (port 53), breaking everything the app needs to resolve by name. A common first mistake when adopting default-deny (see troubleshooting issue #14).\\n- `allow-app-ingress.yaml` \\u2014 the only inbound traffic explicitly permitted: requests to the application's port, which also covers kubelet probes and Prometheus scraping.\\n\\n**Access control**: no static credentials anywhere in the stack \\u2014 ACR access is via the AKS managed identity (`AcrPull` role), Key Vault access via a dedicated managed identity (`Key Vault Secrets User` role), and the CI automation token is scoped to the minimum GitLab role needed to push manifest updates.\\n\\n---\\n\\n## 5. Secrets Management & Microsoft Entra Workload Identity\\n\\nSecrets are never committed in plaintext to Git or embedded directly into the application container.\\n\\nThe platform uses **Microsoft Entra Workload Identity** with the **AKS OIDC issuer**, a dedicated Kubernetes **ServiceAccount**, a **User Assigned Managed Identity (UAMI)**, **Azure RBAC**, and the **Secrets Store CSI Driver** with the Azure Key Vault provider.\\n\\nThis provides a passwordless, identity-based authentication mechanism for Kubernetes workloads accessing Azure resources.\\n\\n### Authentication & Secret Retrieval Flow\\n\\n```text\\n\\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n\\u2502       Application Pod        \\u2502\\n\\u2502                              \\u2502\\n\\u2502  Spring Boot application     \\u2502\\n\\u2502  Kubernetes ServiceAccount   \\u2502\\n\\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n               \\u2502\\n               \\u2502 Projected ServiceAccount token\\n               \\u25bc\\n\\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n\\u2502       AKS OIDC Issuer        \\u2502\\n\\u2502                              \\u2502\\n\\u2502 Trusted token issuer for     \\u2502\\n\\u2502 Kubernetes workloads         \\u2502\\n\\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n               \\u2502\\n               \\u2502 OIDC federation\\n               \\u25bc\\n\\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n\\u2502      Microsoft Entra ID      \\u2502\\n\\u2502                              \\u2502\\n\\u2502 Federated Identity           \\u2502\\n\\u2502 Credential (FIC)             \\u2502\\n\\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n               \\u2502\\n               \\u2502 Federated authentication\\n               \\u25bc\\n\\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n\\u2502  User Assigned Managed       \\u2502\\n\\u2502  Identity (UAMI)             \\u2502\\n\\u2502                              \\u2502\\n\\u2502 Dedicated Azure identity     \\u2502\\n\\u2502 for the workload             \\u2502\\n\\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n               \\u2502\\n               \\u2502 Azure RBAC\\n               \\u2502 Key Vault Secrets User\\n               \\u25bc\\n\\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n\\u2502        Azure Key Vault       \\u2502\\n\\u2502                              \\u2502\\n\\u2502      Application secrets     \\u2502\\n\\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n               \\u2502\\n               \\u2502 Secret retrieval\\n               \\u25bc\\n\\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n\\u2502    Secrets Store CSI Driver  \\u2502\\n\\u2502                              \\u2502\\n\\u2502 + Azure Key Vault Provider   \\u2502\\n\\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u252c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n               \\u2502\\n               \\u2502 Mount / synchronize\\n               \\u25bc\\n\\u250c\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2510\\n\\u2502       Application Pod        \\u2502\\n\\u2502                              \\u2502\\n\\u2502 Secret available at runtime  \\u2502\\n\\u2514\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2518\\n```\\n\\n### How Workload Identity Works\\n\\nThe application Pod does not contain an Azure client secret, password, or long-lived service principal credential.\\n\\nInstead, the workload is associated with a dedicated Kubernetes **ServiceAccount**.\\n\\nThe AKS cluster is configured with:\\n\\n* an **OIDC issuer**;\\n* **Microsoft Entra Workload Identity**;\\n* a Kubernetes **ServiceAccount** configured for workload identity.\\n\\nA **Federated Identity Credential (FIC)** establishes a trust relationship between the AKS OIDC issuer and the **User Assigned Managed Identity**. The federation is scoped to the expected Kubernetes identity, including the ServiceAccount and namespace.\\n\\nAt runtime, the Kubernetes workload obtains a projected ServiceAccount token issued by the AKS OIDC issuer. Microsoft Entra ID validates this token against the configured Federated Identity Credential and allows the workload to authenticate as the associated UAMI.\\n\\nThe UAMI is then authorized through **Azure RBAC** to access only the Azure resources required by the workload.\\n\\nIn this project, the UAMI receives the:\\n\\n**`Key Vault Secrets User`**\\n\\nrole on the Azure Key Vault.\\n\\nThis separates three concerns:\\n\\n```text\\nAuthentication\\n    \\u2193\\nAKS OIDC + Microsoft Entra Workload Identity\\n\\nIdentity\\n    \\u2193\\nUser Assigned Managed Identity\\n\\nAuthorization\\n    \\u2193\\nAzure RBAC\\n\\nSecret storage\\n    \\u2193\\nAzure Key Vault\\n```\\n\\n### Key Components\\n\\n| Component                             | Role                                                                      |\\n| ------------------------------------- | ------------------------------------------------------------------------- |\\n| **AKS OIDC Issuer**                   | Issues the federated identity token used by Kubernetes workloads          |\\n| **Microsoft Entra Workload Identity** | Enables passwordless federation between Kubernetes and Microsoft Entra ID |\\n| **Kubernetes ServiceAccount**         | Represents the workload identity inside the AKS cluster                   |\\n| **Federated Identity Credential**     | Establishes trust between the AKS OIDC issuer and the UAMI                |\\n| **User Assigned Managed Identity**    | Provides the Azure identity used by the workload                          |\\n| **Azure RBAC**                        | Authorizes the UAMI to access specific Azure resources                    |\\n| **Azure Key Vault**                   | Centralized storage for application secrets                               |\\n| **Secrets Store CSI Driver**          | Integrates Kubernetes workloads with external secret stores               |\\n| **Azure Key Vault Provider**          | Enables the CSI Driver to retrieve secrets from Azure Key Vault           |\\n\\n### SecretProviderClass\\n\\nThe Kubernetes `SecretProviderClass` defines how the workload retrieves secrets from Azure Key Vault.\\n\\nIt contains configuration such as:\\n\\n* the Key Vault reference;\\n* the tenant configuration;\\n* the objects/secrets to retrieve;\\n* the workload identity integration.\\n\\nIt **does not contain the actual secret values**.\\n\\nThe secret remains stored in Azure Key Vault and is retrieved at runtime through the identity assigned to the workload.\\n\\n### Runtime Secret Retrieval\\n\\nThe complete runtime path is:\\n\\n```text\\nKubernetes Deployment\\n        \\u2502\\n        \\u2502 ServiceAccount\\n        \\u25bc\\nKubernetes Pod\\n        \\u2502\\n        \\u2502 Workload Identity\\n        \\u25bc\\nAKS OIDC Issuer\\n        \\u2502\\n        \\u2502 Federated token\\n        \\u25bc\\nMicrosoft Entra ID\\n        \\u2502\\n        \\u2502 Authenticate as UAMI\\n        \\u25bc\\nUser Assigned Managed Identity\\n        \\u2502\\n        \\u2502 Azure RBAC\\n        \\u2502 Key Vault Secrets User\\n        \\u25bc\\nAzure Key Vault\\n        \\u2502\\n        \\u2502 Secret retrieval\\n        \\u25bc\\nAzure Key Vault Provider\\n        \\u2502\\n        \\u25bc\\nSecrets Store CSI Driver\\n        \\u2502\\n        \\u25bc\\nApplication Pod\\n```\\n\\nThis creates a clear separation between **configuration, identity, authorization, and secret data**:\\n\\n```text\\nKubernetes configuration\\n        \\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u25ba Git\\n\\nWorkload identity\\n        \\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u25ba AKS OIDC + Entra Workload Identity\\n\\nAzure identity\\n        \\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u25ba User Assigned Managed Identity\\n\\nAuthorization\\n        \\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u25ba Azure RBAC\\n\\nSecret values\\n        \\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u25ba Azure Key Vault\\n```\\n\\n### Infrastructure as Code\\n\\nThe Azure-side identity and access model is provisioned through Terraform.\\n\\nThe Terraform configuration manages:\\n\\n* AKS Workload Identity / OIDC configuration;\\n* the User Assigned Managed Identity;\\n* Azure Key Vault;\\n* Azure RBAC role assignments;\\n* the required Key Vault integration.\\n\\nThe Kubernetes configuration defines the workload-side integration:\\n\\n* Kubernetes ServiceAccount;\\n* Workload Identity configuration;\\n* `SecretProviderClass`;\\n* application Deployment;\\n* CSI volume configuration.\\n\\nThis makes the identity and secret-management architecture reproducible rather than dependent on manual portal configuration.\\n\\n### Security Benefits\\n\\nThis architecture provides:\\n\\n* **No Azure client secrets stored in Git**.\\n* **No Azure credentials embedded in container images**.\\n* **No long-lived Azure credentials inside application Pods**.\\n* **Federated authentication through the AKS OIDC issuer**.\\n* **A dedicated Azure identity for the workload**.\\n* **Least-privilege authorization through Azure RBAC**.\\n* **Centralized secret storage in Azure Key Vault**.\\n* **Runtime secret retrieval through the CSI integration**.\\n* **Separation between GitOps configuration and secret values**.\\n* **Reduced credential-management and rotation overhead**.\\n\\n### ACR Authentication Is Separate\\n\\nThe AKS authentication path to Azure Container Registry is intentionally separate from the Key Vault workload identity path.\\n\\nThe AKS **kubelet managed identity** is granted the:\\n\\n**`AcrPull`**\\n\\nrole on the Azure Container Registry.\\n\\nTherefore:\\n\\n```text\\nImage pull\\n\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\n\\nAKS kubelet identity\\n        \\u2502\\n        \\u2502 AcrPull\\n        \\u25bc\\nAzure Container Registry\\n```\\n\\nwhile:\\n\\n```text\\nApplication secret retrieval\\n\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\n\\nApplication ServiceAccount\\n          \\u2502\\n          \\u25bc\\n      AKS OIDC\\n          \\u2502\\n          \\u25bc\\nMicrosoft Entra Workload Identity\\n          \\u2502\\n          \\u25bc\\n        UAMI\\n          \\u2502\\n          \\u2502 Key Vault Secrets User\\n          \\u25bc\\n   Azure Key Vault\\n```\\n\\nThese are two distinct identity paths with different scopes and responsibilities.\\n\\n### Secret Rotation\\n\\nSecrets are managed centrally in Azure Key Vault rather than being versioned with the application configuration.\\n\\nWhen a secret is rotated in Key Vault, the Secrets Store CSI Driver can detect and synchronize the updated value according to its configured rotation mechanism.\\n\\nThe secret value therefore does not need to be stored in Git or transmitted through the CI/CD pipeline.\\n\\nThe deployment pipeline only manages the application and Kubernetes configuration; it does not need to contain the secret value itself.\\n\\n---\\n\\n## 6. Autoscaling\\n\\n`k8s/base/hpa.yaml` defines a **Horizontal Pod Autoscaler** that scales the application's replica count (1 to 4) based on observed CPU and memory utilization against the requests defined in the Deployment. HPA thresholds are only meaningful if the underlying resource *requests* are realistic \\u2014 this is directly tied to the capacity issues documented in troubleshooting issue #13.\\n\\n---\\n\\n## 7. Observability & Alerting\\n\\n- **Metrics collection**: Prometheus (`kube-prometheus-stack`, configured via `observability/values-monitoring.yaml`, scheduled on the dedicated `monitoring` node pool) scrapes two levels of metrics:\\n- **Infrastructure-level** \\u2014 node-exporter, kube-state-metrics, available out of the box.\\n- **Application-level** \\u2014 JVM and HTTP metrics exposed by the Spring Boot app via Micrometer/Actuator (`/actuator/prometheus`), discovered through the `ServiceMonitor` in `k8s/overlays/dev/servicemonitor.yaml`. Prometheus does **not** auto-discover custom applications \\u2014 this has to be declared explicitly, and the ServiceMonitor's `release` label must match what the Helm release expects, or it's silently ignored (see troubleshooting issue #11).\\n\\n**Dashboards**: `observability/dashboard-portfolio-app.json` is a Grafana dashboard **versioned in the repository** and loaded automatically via a labeled ConfigMap (`observability/dashboard-configmap.yaml`), rather than existing only as a manually imported dashboard in the Grafana UI \\u2014 the visualization is reproducible and survives a Grafana pod restart, not a manual click-through step that has to be redone.\\n\\nTo find it: open Grafana (see [Getting Started](#getting-started)), go to **Dashboards** in the left sidebar \\u2014 it appears in the list as **\\\"Portfolio App - Vue d'ensemble\\\"**, no manual import needed. It shows HTTP request rate by status, p95 latency, CPU usage against limits, and current HPA replica count.\\n\\n**Alerting**: `k8s/overlays/dev/alerts.yaml` defines `PrometheusRule` resources evaluated continuously:\\n- Pod crash-loop detection.\\n- Sustained high CPU usage (>80%, correlated with whether the HPA is responding).\\n- Pod not-ready for a prolonged period.\\n\\nAlertmanager (part of `kube-prometheus-stack`) receives firing alerts, closing the loop from *metric* \\u2192 *rule evaluation* \\u2192 *alert*, rather than leaving dashboards as something that has to be watched manually to be useful.\\n\\n---\\n\\n## Repository Structure\\n\\n```text\\n.\\n\\u251c\\u2500\\u2500 .gitignore\\n\\u251c\\u2500\\u2500 .gitlab-ci.yml                         # GitLab CI/CD pipeline\\n\\u251c\\u2500\\u2500 CHANGELOG.md\\n\\u251c\\u2500\\u2500 Dockerfile                             # Multi-stage, non-root container\\n\\u251c\\u2500\\u2500 TRADE-OFFS.md\\n\\u2502\\n\\u251c\\u2500\\u2500 ai-agent/                              # AI-powered Kubernetes incident investigator\\n\\u2502   \\u251c\\u2500\\u2500 ai-security-report.md              # AI security analysis report\\n\\u2502   \\u251c\\u2500\\u2500 ai_security_review.py              # AI security review\\n\\u2502   \\u251c\\u2500\\u2500 demo-scenarios.md                  # Agent demonstration scenarios\\n\\u2502   \\u251c\\u2500\\u2500 docs/\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 ai-agent-README.md\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 ai-agent-troubleshooting.md\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 images/\\n\\u2502   \\u2502   \\u2502   \\u251c\\u2500\\u2500 question2.png\\n\\u2502   \\u2502   \\u2502   \\u251c\\u2500\\u2500 response1.png\\n\\u2502   \\u2502   \\u2502   \\u2514\\u2500\\u2500 response2.png\\n\\u2502   \\u2502   \\u2514\\u2500\\u2500 screenshots/\\n\\u2502   \\u2502       \\u251c\\u2500\\u2500 aisearch_configuration/\\n\\u2502   \\u2502       \\u251c\\u2500\\u2500 application_state.png\\n\\u2502   \\u2502       \\u251c\\u2500\\u2500 cluster_pods.png\\n\\u2502   \\u2502       \\u251c\\u2500\\u2500 dashboard_grafana.png\\n\\u2502   \\u2502       \\u251c\\u2500\\u2500 pipeline.png\\n\\u2502   \\u2502       \\u2514\\u2500\\u2500 prometheus-targethealth.png\\n\\u2502   \\u2514\\u2500\\u2500 gitlab-federated-credential.json\\n\\u2502\\n\\u251c\\u2500\\u2500 argocd/\\n\\u2502   \\u251c\\u2500\\u2500 application-dev.yaml               # ArgoCD Application\\n\\u2502   \\u2514\\u2500\\u2500 kustomization.yaml\\n\\u2502\\n\\u251c\\u2500\\u2500 docs/\\n\\u2502   \\u251c\\u2500\\u2500 architecture/\\n\\u2502   \\u2502   \\u2514\\u2500\\u2500 architecture_devsecops.png\\n\\u2502   \\u251c\\u2500\\u2500 ci-variables.md\\n\\u2502   \\u2514\\u2500\\u2500 screenshots/\\n\\u2502       \\u251c\\u2500\\u2500 argocd/\\n\\u2502       \\u251c\\u2500\\u2500 azure/\\n\\u2502       \\u251c\\u2500\\u2500 cluster/\\n\\u2502       \\u251c\\u2500\\u2500 grafana/\\n\\u2502       \\u251c\\u2500\\u2500 pipeline/\\n\\u2502       \\u2514\\u2500\\u2500 prometheus/\\n\\u2502\\n\\u251c\\u2500\\u2500 k8s/\\n\\u2502   \\u251c\\u2500\\u2500 agent-investigator/                # Kubernetes resources for AI Agent\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 auth/\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 cluster-issuer-prod.yaml\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 cluster-issuer-staging.yaml\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 ingress.yaml\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 kubernetes-mcp-config.yaml\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 kubernetes-mcp-deployment.yaml\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 namespace.yaml\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 networkpolicy.yaml\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 prometheus-mcp-deployment.yaml\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 pushgateway-deployment.yaml\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 pushgateway-servicemonitor.yaml\\n\\u2502   \\u2502   \\u2514\\u2500\\u2500 rbac.yaml\\n\\u2502   \\u2502\\n\\u2502   \\u251c\\u2500\\u2500 base/                              # Application base manifests\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 deployment.yaml\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 hpa.yaml\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 kustomization.yaml\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 secret-provider-class.yaml\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 service.yaml\\n\\u2502   \\u2502   \\u2514\\u2500\\u2500 serviceaccount.yaml\\n\\u2502   \\u2502\\n\\u2502   \\u251c\\u2500\\u2500 overlays/\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 dev/\\n\\u2502   \\u2502   \\u2502   \\u251c\\u2500\\u2500 alerts.yaml\\n\\u2502   \\u2502   \\u2502   \\u251c\\u2500\\u2500 kustomization.yaml\\n\\u2502   \\u2502   \\u2502   \\u2514\\u2500\\u2500 servicemonitor.yaml\\n\\u2502   \\u2502   \\u2514\\u2500\\u2500 staging/\\n\\u2502   \\u2502       \\u2514\\u2500\\u2500 kustomization.yaml\\n\\u2502   \\u2502\\n\\u2502   \\u2514\\u2500\\u2500 security/\\n\\u2502       \\u251c\\u2500\\u2500 kyverno/\\n\\u2502       \\u2502   \\u251c\\u2500\\u2500 disallow-latest-tag.yaml\\n\\u2502       \\u2502   \\u2514\\u2500\\u2500 disallow-root-user.yaml\\n\\u2502       \\u2514\\u2500\\u2500 network-policies/\\n\\u2502           \\u251c\\u2500\\u2500 allow-app-ingress.yaml\\n\\u2502           \\u251c\\u2500\\u2500 allow-dns.yaml\\n\\u2502           \\u251c\\u2500\\u2500 default-deny-all.yaml\\n\\u2502           \\u2514\\u2500\\u2500 kustomization.yaml\\n\\u2502\\n\\u251c\\u2500\\u2500 observability/\\n\\u2502   \\u251c\\u2500\\u2500 dashboard-configmap.yaml            # Grafana dashboard provisioning\\n\\u2502   \\u251c\\u2500\\u2500 dashboard-portfolio-app.json        # Grafana dashboard\\n\\u2502   \\u2514\\u2500\\u2500 values-monitoring.yaml              # kube-prometheus-stack values\\n\\u2502\\n\\u251c\\u2500\\u2500 scripts/\\n\\u2502   \\u2514\\u2500\\u2500 bootstrap-backend.sh                # Terraform remote backend bootstrap\\n\\u2502\\n\\u251c\\u2500\\u2500 src/\\n\\u2502   \\u251c\\u2500\\u2500 main/\\n\\u2502   \\u2502   \\u251c\\u2500\\u2500 java/\\n\\u2502   \\u2502   \\u2502   \\u2514\\u2500\\u2500 com/\\n\\u2502   \\u2502   \\u2514\\u2500\\u2500 resources/\\n\\u2502   \\u2502       \\u2514\\u2500\\u2500 application.properties\\n\\u2502   \\u2514\\u2500\\u2500 test/\\n\\u2502\\n\\u251c\\u2500\\u2500 terraform/\\n\\u2502   \\u251c\\u2500\\u2500 acr.tf                              # Azure Container Registry\\n\\u2502   \\u251c\\u2500\\u2500 aks.tf                              # AKS + OIDC / Workload Identity\\n\\u2502   \\u251c\\u2500\\u2500 backend.tf                           # Remote Terraform backend\\n\\u2502   \\u251c\\u2500\\u2500 foundry.tf                           # Azure AI Foundry\\n\\u2502   \\u251c\\u2500\\u2500 keyvault.tf                          # Azure Key Vault + RBAC\\n\\u2502   \\u251c\\u2500\\u2500 main.tf\\n\\u2502   \\u251c\\u2500\\u2500 monitoring-node-pool.tf              # Dedicated monitoring node pool\\n\\u2502   \\u251c\\u2500\\u2500 outputs.tf\\n\\u2502   \\u251c\\u2500\\u2500 providers.tf\\n\\u2502   \\u2514\\u2500\\u2500 variables.tf\\n\\u2502\\n\\u251c\\u2500\\u2500 devsecops-README.md\\n\\u251c\\u2500\\u2500 devsecops-troubleshooting.md\\n\\u251c\\u2500\\u2500 mvnw\\n\\u251c\\u2500\\u2500 mvnw.cmd\\n\\u251c\\u2500\\u2500 pom.xml\\n\\u2514\\u2500\\u2500 readme.md\\n```\\n\\n### Key Architectural Areas\\n\\n* **`terraform/`** \\u2014 Azure infrastructure provisioned through Infrastructure as Code, including AKS, ACR, Azure Key Vault, monitoring infrastructure, and Azure AI Foundry resources.\\n* **`k8s/base/`** \\u2014 reusable Kubernetes resources shared across environments.\\n* **`k8s/agent-investigator/`** \\u2014 Kubernetes manifests for the AI-powered incident investigation components, including Kubernetes MCP, Prometheus MCP, Pushgateway, RBAC, networking, ingress, and authentication.\\n* **`k8s/overlays/`** \\u2014 environment-specific Kustomize configuration for `dev` and `staging`.\\n* **`k8s/security/`** \\u2014 runtime security policies using Kyverno and Kubernetes NetworkPolicies.\\n* **`observability/`** \\u2014 Prometheus/Grafana configuration and dashboard provisioning.\\n* **`argocd/`** \\u2014 GitOps application definitions used by ArgoCD.\\n* **`docs/`** \\u2014 architecture documentation, screenshots, and the real troubleshooting history.\\n* **`src/`** \\u2014 Spring Boot application source code and tests.\\n\\nThe repository therefore contains both the **platform infrastructure** and the **application workload**, with infrastructure, security, identity, observability, GitOps, and AI-assisted incident investigation represented declaratively in code.\\n\\n---\\n\\n## Getting Started\\n\\n```bash\\n# 1. Bootstrap the Terraform remote state backend (one-time)\\n./scripts/bootstrap-backend.sh\\n\\n# 2. Provision infrastructure\\ncd terraform && terraform init && terraform apply\\n\\n# 3. Install ArgoCD and Kyverno\\nkubectl create namespace argocd\\nkubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml\\nkubectl apply -f https://github.com/kyverno/kyverno/releases/latest/download/install.yaml\\nkubectl apply -f k8s/security/kyverno/\\n\\n# 4. Deploy the application (ArgoCD takes over from here)\\nkubectl apply -f argocd/application-dev.yaml\\n\\n# 5. Install observability\\nhelm install monitoring prometheus-community/kube-prometheus-stack \\\\\\n  --namespace monitoring -f observability/values-monitoring.yaml\\nkubectl apply -f k8s/overlays/dev/alerts.yaml\\nkubectl apply -f observability/dashboard-configmap.yaml\\n\\n# 6. Verify metrics are being scraped\\nkubectl port-forward -n monitoring svc/monitoring-kube-prometheus-prometheus 9090:9090\\n# \\u2192 Status > Targets should show portfolio-app as UP\\n\\n# 7. Access Grafana\\nkubectl port-forward -n monitoring svc/prometheus-stack-grafana 3000:80\\n# \\u2192 login: admin / <password set at install>\\n# \\u2192 Dashboards (left sidebar) > \\\"Portfolio App - Vue d'ensemble\\\"\\n```\\n\\nFull step-by-step detail, including every error actually hit along the way, is in [`devsecops-troubleshooting.md`](devsecops-troubleshooting.md).\\n\\n---\\n\\n## Cost Management\\n\\n- Infrastructure destroyed (`terraform destroy`) or scaled down (`az aks stop`, monitoring node pool scaled to 0) between work sessions.\\n- The `monitoring` node pool is isolated specifically so it can be scaled independently of the application pool without affecting it.\\n- An Azure budget alert was configured as soon as the first billable resources were added.\\n\\n---\\n\\n## Screenshots\\n\\n[`screenshots`](screenshots)\\n\\n---\\n\\n**Author**: Hajar Zouhair \\u2014 DevOps/DevSecOps Engineer\\n\\n\\n---\\n\\n\\n# Troubleshooting Log\\n\\nReal issues encountered while building this project, with root causes and fixes \\u2014 kept as a record of actual debugging work rather than a polished \\\"everything worked first try\\\" narrative.\\n\\n\\n---\\n\\n## 1. Subnet Resource Not Found During Terraform Polling\\n\\n**Symptom**: Terraform reported `ResourceNotFound` for a subnet while polling its provisioning state, even though Azure CLI confirmed the subnet existed with `ProvisioningState: Succeeded`.\\n\\n**Diagnosis**: `terraform state list` showed the resource group and VNet, but not the subnet \\u2014 it existed in Azure but was missing from Terraform's state.\\n\\n**Fix**: imported the existing subnet into state with `terraform import azurerm_subnet.aks <resource-id>`.\\n\\n**Lesson**: a resource existing in the cloud provider does not guarantee it exists in Terraform's state \\u2014 state and reality can diverge, especially after partial applies.\\n\\n\\n---\\n\\n## 2. AKS OIDC Issuer Feature Cannot Be Disabled\\n\\n**Symptom**: `terraform apply` failed updating the AKS cluster (triggered by adding the Key Vault CSI provider add-on): `OIDCIssuerFeatureCannotBeDisabled`. The plan showed `oidc_issuer_enabled = true -> null`.\\n\\n**Diagnosis**: Azure enables the OIDC issuer by default on new clusters; because `aks.tf` never declared this attribute, Terraform's implicit default (unset) caused it to attempt disabling a feature Azure won't allow turning off.\\n\\n**Fix**: declared `oidc_issuer_enabled = true` explicitly, matching actual state.\\n\\n**Lesson**: cloud providers can enable features by default independently of what's declared in Terraform \\u2014 an unset attribute is not neutral if the provider has its own default.\\n\\n---\\n\\n## 3. Mise en place de Workload Identity pour Key Vault (en 4 \\u00e9tapes)\\n\\n**Symptom**: la configuration initiale du Key Vault CSI Driver reposait sur `useVMManagedIdentity: \\\"true\\\"` et l'identit\\u00e9 du node. Un pod de test montant un secret Key Vault restait bloqu\\u00e9 en `ContainerCreating`, avec `FailedMount`: `ManagedIdentityCredential: ... Multiple user assigned identities exist, please specify the clientId`.\\n\\n**Diagnosis**: le cluster AKS portait plusieurs managed identities simultan\\u00e9ment (celle du kubelet pour les pulls ACR, et celle auto-cr\\u00e9\\u00e9e par l'add-on Key Vault CSI) \\u2014 l'identit\\u00e9 du node n'\\u00e9tait pas assez granulaire pour repr\\u00e9senter un workload particulier, et le m\\u00e9canisme ne correspondait pas au mod\\u00e8le Workload Identity finalement retenu.\\n\\n**Fix**, en 4 \\u00e9tapes :\\n\\n1. **Activer les deux fonctionnalit\\u00e9s AKS requises** \\u2014 l'OIDC issuer seul ne suffit pas ; il faut aussi activer Workload Identity explicitement dans Terraform :\\n\\n`oidc_issuer_enabled = true`\\n`workload_identity_enabled = true`\\n\\n\\n2. **Migrer l'identit\\u00e9 du node vers l'identit\\u00e9 du workload** \\u2014 faire porter l'identit\\u00e9 sur un Kubernetes ServiceAccount plut\\u00f4t que sur le node, pour une granularit\\u00e9 fine par workload.\\n\\n3. **R\\u00e9cup\\u00e9rer le `clientId` de l'identit\\u00e9 d\\u00e9di\\u00e9e** \\u00e0 l'add-on Key Vault CSI (`az aks show --query addonProfiles.azureKeyvaultSecretsProvider.identity.clientId`) et le d\\u00e9clarer explicitement comme `userAssignedIdentityID` dans le `SecretProviderClass`, pour lever l'ambigu\\u00eft\\u00e9 entre les identit\\u00e9s multiples.\\n\\n4. **Configurer le `SecretProviderClass`** pour utiliser le mod\\u00e8le Workload Identity avec les valeurs propres \\u00e0 l'environnement (tenant, identit\\u00e9 Azure concern\\u00e9e).\\n\\nLe flux final obtenu :\\n\\nPod\\n\\u2502\\n\\u2502 ServiceAccount\\n\\u25bc\\nWorkload Identity\\n\\u2502\\n\\u2502 OIDC\\n\\u25bc\\nMicrosoft Entra ID\\n\\u2502\\n\\u2502 Managed Identity\\n\\u25bc\\nAzure Key Vault\\n\\u2502\\n\\u2502 secret\\n\\u25bc\\nSecrets Store CSI Driver\\n\\u2502\\n\\u25bc\\nPod\\n\\n**Lesson**: un cluster peut porter plusieurs managed identities pour diff\\u00e9rents add-ons \\u2014 \\\"l'identit\\u00e9 manag\\u00e9e\\\" n'est pas toujours singuli\\u00e8re. Une identit\\u00e9 attach\\u00e9e au node et une identit\\u00e9 attach\\u00e9e au workload r\\u00e9pondent \\u00e0 des besoins diff\\u00e9rents : Workload Identity permet une granularit\\u00e9 fine et \\u00e9vite de donner les m\\u00eames privil\\u00e8ges Azure \\u00e0 plusieurs workloads.\\n\\n---\\n\\n## 4. GitLab OIDC Federation \\u2014 Authentication Flow Misconfiguration\\n\\n**Symptom**: l'authentification du pipeline GitLab vers Azure devait fonctionner sans stocker de `client_secret`, mais la configuration OIDC n\\u00e9cessitait de distinguer correctement les diff\\u00e9rents tokens et leurs audiences.\\n\\n**Diagnosis**: GitLab CI g\\u00e9n\\u00e8re un `ID token OIDC` destin\\u00e9 \\u00e0 \\u00eatre pr\\u00e9sent\\u00e9 \\u00e0 `Microsoft Entra ID`. Le token contient notamment une audience (aud) et une identit\\u00e9 (sub). Azure utilise ces informations dans une Federated Identity Credential pour d\\u00e9terminer si le token provenant de GitLab est autoris\\u00e9 \\u00e0 repr\\u00e9senter l'identit\\u00e9 Azure cibl\\u00e9e. Les diff\\u00e9rents usages OIDC du projet ne pouvaient donc pas \\u00eatre trait\\u00e9s comme une seule f\\u00e9d\\u00e9ration g\\u00e9n\\u00e9rique : chaque trust devait correspondre au bon issuer, subject et audience.\\n\\n**Fix**: configuration de f\\u00e9d\\u00e9rations OIDC distinctes correspondant aux diff\\u00e9rents usages du pipeline, notamment l'authentification utilis\\u00e9e par `push_to_acr` avec `AZURE_ID_TOKEN`. Le pipeline a ensuite pu obtenir une identit\\u00e9 Azure temporaire sans stocker de secret longue dur\\u00e9e.\\n\\n**Lesson**: OIDC n'est pas simplement \\u00ab activer un token \\u00bb. La f\\u00e9d\\u00e9ration repose sur une correspondance pr\\u00e9cise entre issuer + subject + audience. Une mauvaise audience ou un mauvais sujet peut rendre un token parfaitement valide inutilisable aupr\\u00e8s d'Azure.\\n\\n---\\n\\n## 5. Workload Identity Federation \\u2014 ServiceAccount / Managed Identity Trust\\n\\n**Symptom**: apr\\u00e8s avoir activ\\u00e9 Workload Identity, le pod devait encore \\u00eatre explicitement associ\\u00e9 \\u00e0 l'identit\\u00e9 Azure appropri\\u00e9e pour pouvoir acc\\u00e9der au Key Vault.\\n\\n**Diagnosis**: activer Workload Identity sur AKS ne cr\\u00e9e pas automatiquement une relation de confiance entre n'importe quel ServiceAccount Kubernetes et n'importe quelle Managed Identity Azure. Une Federated Identity Credential doit d\\u00e9finir pr\\u00e9cis\\u00e9ment quelle identit\\u00e9 Kubernetes est autoris\\u00e9e \\u00e0 repr\\u00e9senter la Managed Identity.\\n\\nLa relation de confiance repose notamment sur :\\n\\n1. issuer\\n2. subject\\n3. audience\\n\\nLe subject permet notamment d'identifier le ServiceAccount Kubernetes concern\\u00e9.\\n\\n**Fix**: cr\\u00e9ation/configuration de la f\\u00e9d\\u00e9ration entre le ServiceAccount Kubernetes du workload et la User Assigned Managed Identity Azure, puis utilisation de cette identit\\u00e9 par le workload.\\n\\n**Lesson**: Workload Identity repose sur une relation de confiance explicite. Poss\\u00e9der un ServiceAccount Kubernetes et une Managed Identity Azure ne suffit pas : la f\\u00e9d\\u00e9ration entre les deux doit \\u00eatre configur\\u00e9e.\\n\\n## 6. Key Vault Access \\u2014 Authentication vs Authorization\\n\\n**Symptom**: m\\u00eame apr\\u00e8s avoir mis en place l'identit\\u00e9 permettant au workload de s'authentifier aupr\\u00e8s d'Azure, l'acc\\u00e8s au secret Key Vault n\\u00e9cessitait encore une configuration suppl\\u00e9mentaire.\\n\\n**Diagnosis**: deux probl\\u00e8mes distincts avaient \\u00e9t\\u00e9 rencontr\\u00e9s :\\n\\nAuthentication :\\n\\u00ab Qui es-tu ? \\u00bb\\n        \\u2193\\nWorkload Identity\\n\\net :\\n\\nAuthorization\\n\\u00ab Qu'as-tu le droit de faire ? \\u00bb\\n        \\u2193\\nAzure RBAC\\n\\nLa Managed Identity devait donc recevoir les permissions n\\u00e9cessaires sur le Key Vault.\\n\\n**Fix**: attribution du r\\u00f4le Azure RBAC appropri\\u00e9, notamment Key Vault Secrets User, \\u00e0 l'identit\\u00e9 utilis\\u00e9e par le workload.\\n\\n**Lesson**: une authentification r\\u00e9ussie ne signifie pas qu'une op\\u00e9ration Azure est autoris\\u00e9e. Il faut toujours distinguer identit\\u00e9 et permissions.\\n\\n---\\n\\n## 7. Trivy Security Gate Blocking the Pipeline\\n\\n**Symptom**: `container_scan` failed after enabling `trivy image --exit-code 1 --severity HIGH,CRITICAL`, reporting HIGH vulnerabilities in the Alpine base image (`libexpat`, `p11-kit`, `p11-kit-trust`) while the application JAR itself was clean.\\n\\n**Diagnosis**: a local scan confirmed the vulnerabilities were entirely in outdated Alpine OS packages in the `eclipse-temurin:21-jre-alpine` runtime layer, not in Java dependencies \\u2014 fixed versions existed upstream (e.g. `libexpat 2.8.1-r0 -> 2.8.2-r0`).\\n\\n**Fix**: added `RUN apk update && apk upgrade` to the runtime stage of the Dockerfile, then rebuilt with `--no-cache` to guarantee the updated packages were actually installed (not served from a stale layer cache).\\n\\n**Validation**: a rescan showed 0 vulnerabilities in both the OS layer and the application JAR.\\n\\n**Security posture note**: the gate was deliberately never weakened with `--exit-code 0` \\u2014 the image was fixed and rescanned until it passed, not exempted from the check.\\n\\n**Lesson**: container scanning must cover OS packages, not just application dependencies \\u2014 a clean application layer doesn't guarantee a secure image, and vulnerabilities should be fixed rather than bypassed by relaxing the scanner.\\n\\n---\\n\\n## 8. CreateContainerConfigError \\u2014 Non-Numeric User with `runAsNonRoot`\\n\\n**Symptom**: after the ArgoCD sync, the pod failed to start: `Error: container has runAsNonRoot and image has non-numeric user (spring), cannot verify user is non-root`. As a side effect, the HPA also reported `<unknown>` CPU/memory metrics.\\n\\n**Diagnosis**: the pod's `securityContext` required `runAsNonRoot: true` (enforced for defense-in-depth, matching the Kyverno `disallow-root-user` policy), but the Dockerfile created the container user by **name** only (`adduser -S spring`) rather than a fixed numeric UID/GID. Kubernetes can only verify `runAsNonRoot` against a numeric UID \\u2014 it cannot resolve a named user inside the image to confirm it isn't UID 0. The HPA's `<unknown>` metrics were a downstream consequence: no container was ever running, so there was nothing for `metrics-server` to report on.\\n\\n**Fix**: updated the Dockerfile to create the user with an explicit numeric UID/GID (`addgroup -g 1001 -S spring && adduser -u 1001 -S spring -G spring`, `USER 1001`), and declared the matching `runAsUser: 1001` in the Deployment's `securityContext`.\\n\\n**Lesson**: `runAsNonRoot` policies (including Kyverno's `disallow-root-user` here) require numeric UIDs end-to-end \\u2014 a named non-root user in the image is not sufficient on its own.\\n\\n---\\n\\n## 9. Kustomize Load Restriction \\u2014 Cannot Reference Files Outside Overlay Root\\n\\n**Symptom**: `kubectl kustomize k8s/overlays/dev` failed: `accumulating resources ... file '.../k8s/security/network-policies/default-deny-all.yaml' is not in or below '.../k8s/overlays/dev': must build at directory`.\\n\\n**Diagnosis**: recent Kustomize versions restrict plain resource *files* referenced from a kustomization to its own directory tree, as a directory-traversal safety measure. The Network Policies were referenced as three individual files from outside that tree.\\n\\n**Fix**: turned `k8s/security/network-policies/` into its own Kustomize base (its own `kustomization.yaml` listing the three files) \\u2014 a directory with its own `kustomization.yaml` is exempt from this restriction, unlike individual files.\\n\\n**Lesson**: Kustomize treats \\\"plain resource files\\\" and \\\"base directories\\\" under different rules \\u2014 shared resources reused across overlays should always be packaged as a base.\\n\\n---\\n\\n## 10. GitLab CI Bot Token Rejected on Protected Branch\\n\\n**Symptom**: the CI job that commits the updated image tag back to the repo failed: `You are not allowed to push code to protected branches on this project. (pre-receive hook declined)` \\u2014 despite the Project Access Token having `write_repository` scope.\\n\\n**Diagnosis**: GitLab enforces branch protection as a second, independent authorization layer on top of token scopes. Having the right scope does not bypass a protected branch's role restrictions.\\n\\n**Fix**: updated the `master` protected branch rule to allow **Developers** to push directly, matching the token's role \\u2014 rather than elevating the token itself to Maintainer.\\n\\n**Lesson**: branch protection and token scopes are two separate GitLab authorization mechanisms; both must be satisfied. Prefer adjusting the protected branch's allowed roles over granting automation a higher role than it needs.\\n\\n---\\n\\n## 11. Prometheus Showing \\\"No Data\\\" \\u2014 Missing ServiceMonitor\\n\\n**Symptom**: Prometheus had no data at all for the application; even a manually built Grafana panel showed nothing, with no error anywhere.\\n\\n**Diagnosis**: `kube-prometheus-stack` only scrapes targets it's explicitly told about \\u2014 node-exporter and kube-state-metrics come pre-configured, custom applications don't. No `ServiceMonitor` existed for the app, so Prometheus never attempted to scrape it.\\n\\n**Fix**: named the Service port explicitly (`ServiceMonitor` endpoints select by port **name**, not number), then created a `ServiceMonitor` matching the Service's labels \\u2014 critically including the `release: monitoring` label required by the `Prometheus` custom resource's `serviceMonitorSelector`. Without that exact label match, a ServiceMonitor is silently ignored.\\n\\n**Lesson**: check the `serviceMonitorSelector` on the `Prometheus` CR (`kubectl get prometheus -n monitoring -o yaml`) before assuming an applied ServiceMonitor manifest is actually active \\u2014 \\\"applied\\\" and \\\"picked up\\\" are not the same thing.\\n\\n---\\n\\n## 12. 404 Scraping `/actuator/prometheus`\\n\\n**Symptom**: once the ServiceMonitor was in place, Prometheus reported `Error scraping target: server returned HTTP status 404`.\\n\\n**Diagnosis, step by step**:\\n1. Confirmed Service/label selectors were correct \\u2014 Prometheus could reach the pod, ruling out a networking issue.\\n2. Port-forwarded directly to the pod: `curl localhost:8080/actuator` returned `200`, but `_links` only listed `health` \\u2014 isolating the problem to the application layer, not Kubernetes.\\n3. Verified `management.endpoints.web.exposure.include=health,info,prometheus,metrics` and the `micrometer-registry-prometheus` Maven dependency were both present and correct in source.\\n4. Verified the built JAR actually contained the updated `application.properties` (`unzip -p target/*.jar BOOT-INF/classes/application.properties`) \\u2014 confirmed correct.\\n5. **Root cause**: `kubectl get pod -o jsonpath='{.spec.containers[0].image}'` showed the running pod was on an image tag from an **older commit**, predating the Actuator config change \\u2014 confirmed with `git show <old-tag>:src/main/resources/application.properties`.\\n6. A newer, correct pod was already scheduled but stuck `Pending` (see next issue).\\n\\n**Fix**: once the new pod reached `Running`, `/actuator/prometheus` returned `200` with correctly formatted metrics.\\n\\n**Lesson**: a 404 from an observability stack is rarely about the observability stack. Isolate app-level (`curl` directly to the pod) from cluster-level (Service/ServiceMonitor) first \\u2014 and always confirm *which image* is actually running before debugging application code that might already be fixed in Git.\\n\\n---\\n\\n## 13. New Pod Stuck in Pending \\u2014 Insufficient CPU\\n\\n**Symptom**: the corrected pod (issue #12) sat `Pending` for 40+ minutes while the older pod kept running.\\n\\n**Diagnosis**: `kubectl describe pod` showed `0/1 nodes are available: Insufficient cpu`. `kubectl top nodes` confirmed the node pool was near its CPU allocation limit \\u2014 largely because the observability stack (Prometheus, Grafana, Alertmanager) was competing for capacity on the same node pool as the application at the time.\\n\\n**Fix, in order of cost**:\\n1. Reviewed whether the Deployment's CPU requests were oversized relative to actual needs.\\n2. Manually deleted the stale old pod to immediately free capacity the rolling update wasn't reclaiming fast enough.\\n3. As a structural fix, added a **dedicated node pool for the observability stack** (`terraform/monitoring-node-pool.tf`, with a taint), so application and monitoring workloads no longer compete for the same node capacity.\\n\\n**Lesson**: on a resource-constrained cluster, a `Pending` pod is very often a capacity problem caused by *co-located* workloads rather than the workload itself being misconfigured \\u2014 isolating observability onto its own node pool resolved the recurring contention rather than just patching the symptom each time.\\n\\n---\\n\\n## 14. DNS Breakage After Applying `default-deny-all` NetworkPolicy\\n\\n**Symptom**: after applying the default-deny Network Policy, the application pod could no longer resolve any hostname, including internal Kubernetes service names.\\n\\n**Diagnosis**: `default-deny-all` blocks all egress by default, including DNS queries to CoreDNS on port 53 \\u2014 Kubernetes does not implicitly allowlist DNS just because it's infrastructure traffic.\\n\\n**Fix**: added `allow-dns.yaml`, explicitly permitting egress to `kube-system` on UDP/TCP port 53, applied alongside `default-deny-all`.\\n\\n**Lesson**: when adopting a default-deny network model, DNS is the first thing that breaks and the easiest thing to forget \\u2014 apply and test `allow-dns` in the same change as `default-deny-all`, not as an afterthought.\\n\\n---\\n\\n## 15. ArgoCD Application Controller OOMKilled \\u2014 Stale Sync Status\\n\\n**Symptom**: `portfolio-app-dev` stayed `OutOfSync`/degraded in the ArgoCD UI even though the actual Deployment was healthy. `kubectl get pods -n argocd` showed `argocd-application-controller-0` in a repeated `OOMKilled` crash loop.\\n\\n**Diagnosis**: all cluster-critical components (ArgoCD's 7 pods, Kyverno's 4 controllers, CoreDNS, metrics-server, CSI drivers, etc.) were co-located on a single small node. `argocd-application-controller` keeps an in-memory cache of every manifest it watches, and its default memory limit was too low for that load on an already-pressured node \\u2014 it kept getting OOM-killed before it could finish computing sync/health status, leaving the UI showing a stale result.\\n\\n**Fix**: raised the controller's memory limit (`kubectl patch statefulset argocd-application-controller -n argocd ...`), then forced a hard refresh (`argocd.argoproj.io/refresh: hard` annotation) once it stabilized.\\n\\n**Lesson**: a `Degraded`/`OutOfSync` status in ArgoCD doesn't always mean the *application* is unhealthy \\u2014 it can mean ArgoCD itself couldn't finish evaluating it. Check ArgoCD's own component health (`kubectl get pods -n argocd`) before assuming the deployed workload is at fault.\\n\\n---\\n\\n## 16. Grafana p95 Latency Panel Showing \\\"No Data\\\"\\n\\n**Symptom**: three of the four panels in the custom Grafana dashboard displayed real data (HTTP request rate, CPU usage, HPA replica count), but \\\"Latence p95\\\" consistently showed \\\"No data\\\".\\n\\n**Diagnosis**: the panel queries `histogram_quantile(0.95, rate(http_server_requests_seconds_bucket[5m]))`, which requires Micrometer to export **histogram buckets** for HTTP request duration. By default, Micrometer only exposes the counter and sum (`http_server_requests_seconds_count` / `_sum`) \\u2014 the `_bucket` series needed for percentile calculation is not emitted unless explicitly enabled. Since `/actuator/prometheus` was otherwise working correctly (confirmed by the other three panels), the issue was isolated to this specific metric configuration, not scraping or connectivity.\\n\\n**Fix**: added `management.metrics.distribution.percentiles-histogram.http.server.requests=true` to `application.properties`, then rebuilt/redeployed through the normal CI/CD pipeline.\\n\\n**Lesson**: a metric endpoint returning `200` with valid Prometheus-formatted output doesn't guarantee every metric a dashboard expects is actually being exported \\u2014 histogram-based queries (percentiles, quantiles) need buckets explicitly enabled per-metric in Micrometer, they aren't on by default even when the base metric exists.\\n\\n---\\n\\n## Summary of key debugging habits reinforced by this project\\n\\n- Check CRD **label selectors** explicitly (`serviceMonitorSelector`, `ruleSelector`) rather than assuming an applied manifest is automatically\\n\\\"active.\\\"\\n- When something returns an unexpected HTTP status from inside the cluster, isolate app-level from cluster-level first with a direct `curl`, bef\\nore touching Kubernetes config.\\n- Always confirm **which image tag** is actually deployed before assuming a code fix hasn't worked \\u2014 `kubectl get pod -o jsonpath` + `git show <\\ntag>:<file>` is a fast way to rule this in or out.\\n- Resource contention (`Pending` pods, OOM-killed control-plane components) on a small cluster is often caused by *neighboring* workloads \\u2014 chec\\nk `kubectl top nodes` before assuming the workload itself is misconfigured.\\n- A default-deny network policy needs DNS allowlisted explicitly, every time.\\n- A tool's own status UI (ArgoCD's sync/health) can itself be the thing that's broken \\u2014 verify the tool's components are healthy before trusting\\n what it reports about something else.\\n\\n\\n\\n---\\n\\n\\n# Trade-offs \\u2014 Deliberate Scoping Decisions\\n\\nThis file consolidates every deliberate trade-off made across this\\nproject \\u2014 decisions that simplify the architecture for a portfolio\\nproject on a limited Azure credit, made consciously rather than\\ndiscovered by accident. Each is cross-referenced to where it's\\nmentioned in more detail elsewhere.\\n\\n## Networking\\n\\n**Public authenticated Ingress instead of Foundry VNet injection.**\\nAzure AI Foundry is a managed service outside the cluster's VNet. The\\ncorrect production approach would be VNet injection for private\\nconnectivity between Foundry and the Kubernetes/Prometheus MCP\\nservers. Instead, the MCP servers are exposed via an NGINX Ingress\\nprotected by Basic Auth + Let's Encrypt TLS. Accepted for a\\nportfolio-scale project; VNet injection is listed in the agent\\nREADME's roadmap.\\n\\n**`GlobalStandard` SKU for the Foundry model deployment.** The\\noriginally planned `Standard` SKU (regional, data guaranteed to stay\\nin-region) was rejected by Azure in `francecentral`, and the\\noriginally planned model (`gpt-4o-mini`) was later deprecated\\nmid-project. `gpt-5-mini GlobalStandard` was used instead, but does not guarantee the request is processed\\nwithin a specific region. Acceptable here: no data residency\\nrequirement for this project. See `ai-agent/docs/ai-agent-troubleshooting.md`\\n\\u00a710.\\n\\n**Shared static Basic Auth credential across four consumers.** The\\nsame password protects the Ingress and is independently referenced in\\nthe GitLab CI/CD variable, the Kubernetes secret, and two separate MCP\\ntool configurations in the Foundry portal. There is no automatic\\nrotation and no single source of truth \\u2014 a manual credential change\\nmust be propagated to all four places by hand (learned the hard way,\\nsee `docs/ai-agent-troubleshooting.md` \\u00a727). Roadmap: a secret per\\nconsumer, or an automated rotation/vault mechanism.\\n\\n## Azure resource management\\n\\n**The Foundry Project and Agent are not Terraform-managed.** Only the\\nunderlying Cognitive Services account and model deployment are\\nprovisioned via Terraform; the Project and Agent themselves were\\ncreated through the Azure portal. This is a current limitation of the\\n`azurerm` provider on this resource model, not an oversight \\u2014 see\\n`ai-agent/docs/ai-agent-README.md` \\u00a74.\\n\\n**No Azure Monitor / Log Analytics integration.** Prometheus already\\ncovers the metrics the agent needs; adding Azure Monitor would\\nduplicate both data and cost without a clear benefit at this scale.\\n\\n## Agent scope and safety\\n\\n**Diagnose-only, no human-in-the-loop remediation.** The agent can\\ninvestigate and recommend, but never executes a fix \\u2014 not even with\\napproval. A human-in-the-loop flow (agent proposes \\u2192 human approves \\u2192\\nautomated commit/PR) is documented as a roadmap item, not built,\\nbecause it introduces a much larger safety surface than a portfolio\\nproject needs to prove out first.\\n\\n**No observability of interactive Foundry chat usage.** Only\\nCI-triggered agent calls (`ai_security_review`) are currently\\nmonitored via the Pushgateway. Full coverage of interactive portal\\nconversations would require Application Insights \\u2014 left as roadmap.\\n\\n## Infrastructure capacity (free-tier subscription constraints)\\n\\n**No dedicated node pool added for the AI agent's components.** The\\nfree-tier subscription's 4-vCPU regional quota made adding a node\\npool impossible (see `docs/ai-agent-troubleshooting.md` \\u00a711). Instead,\\nall agent components (MCP servers, Pushgateway, cert-manager's solver\\npods, the ingress controller itself) were deliberately scheduled on\\nthe existing, underused `monitoring` node pool rather than the\\n`system` pool. This trades some workload isolation for staying within\\nquota.\\n\\n**`maxSurge: 0` on `portfolio-app`'s rollout strategy.** Chosen to\\navoid needing one extra pod slot during deployments, given the\\ncluster's tight pod-per-node ceiling (Azure CNI's 30-pods-per-node\\nlimit). Trade-off: a brief moment of unavailability during rollouts,\\ninstead of a zero-downtime deployment.\\n\\n## Status of previously-open items\\n\\n**Trivy blocking gate (`|| true` on the exit code check).** This was a\\ntemporary bypass used to capture a real CVE finding for the AI\\nSecurity Review without interrupting iteration. Status: **resolved**\\n\\u2014 the underlying vulnerability (`tomcat-embed-core` CVEs) was fixed at\\nthe dependency level, and the bypass was removed to restore real\\nblocking behavior. Kept here as a record of the decision, since the\\nbypass existed for a real reason and wasn't just an oversight left in\\nplace.\\n\\n\\nagent-knowledge.md\\n\",\n            \"filepath\": \"\",\n            \"title\": \"\",\n            \"url\": \"https://srch-kubesentry-dev.search.windows.net/\",\n            \"score\": 3.1791587,\n            \"knowledgeSourceIndex\": 0\n          }\n        ],\n        \"get_urls\": [\n          \"https://srch-kubesentry-dev.search.windows.net/indexes/kubesentry-index/docs/aHR0cHM6Ly9zdGZrdWJlc2VudHJ5ZGV2LmJsb2IuY29yZS53aW5kb3dzLm5ldC9rbm93bGVkZ2UtZG9jdW1lbnRzL2FnZW50LWtub3dsZWRnZS5tZA2?api-version=2024-07-01&$select=id,content,metadata_storage_name\"\n        ]\n      }",
    "status": "completed"
  },
  {
    "type": "reasoning",
    "id": "rs_0692ec3cf987cc89006afb876d40dc8195aca8c4190dbd7079",
    "agent_reference": {
      "type": "agent_reference",
      "name": "k8s-incident-investigator",
      "version": "7"
    },
    "response_id": "resp_0692ec3cf987cc89006afb8766a4d081959ae930969478f280",
    "encrypted_content": "gAAAAABq-4eDwZIA22TIw5SknPkEia3uO2FxLUuezuuJQEbETh03PvbAxb6IDHl4CethhwRVrYqHOkBdxLLqDWNZjabG1VTwjVl3IgS5X7F4_RKqZVgf3yRwYGju1z3MEeQQhxU9LWpntecFPq2PF6u1J82ODXs_2_Kv56CXTGhuShAypJ54KhYHSzpKGFmNZ37bNGNhoLmchGxt-8azPgeBmNblfNh3ofg6dp9cstutNYkOEQ8Sl1k2EA020dK9J4mWSOKE2eQKVmbL-da0ybR6W4EIEkbQ1AWYDaowbj4ARjZ968hah13kcfLiUC0kfa--tMXJDeiqV7c4QtCTq7FJJDtEEjw6mlFnwEPKci-sJ_PELIDd7e_Pk0lYwnC3PmTix6MTfkR9Up1kIJJxVQK43Kl5BTIpcD_AM4yycb1afphDCIDRzNU9j15v8j9zuCvnvYM12PpXHYxC3tmx2xjBxaeydsU7SyVaAgHemxNglfIUfhFcSAJTXBYaTz83DK19fAw0D5-duYPbd4vtHh8K-c52ND9q0aJlHkaRmsvMOkVORU-WTHmem7C6rjmBTOMbta4gjA1ZnuLQuvByft4KdHiF4jUSbtZZK6EfatydrsOAhWRAxkfoOai1g2Mx14-yoZ9NurKiXTPR1FkkgQ2FG9bxKDVHHI4tGyVgwZ1oOQsAqVzSAdRsR1J98WwvOyUpx0JbJDDbrxoziwg02IEfemQu8-UEfRpCpJ-xcu9BqY8duBoWp_8NwFh41-LOUqDhJ3cLW78J4A_oscdjQ1Cau18ckUuJC5eLzot-b8aRv5Wz5tnKneZ3eTU6BL5XGNJt1o71rNVYCEMZsA55xZAC357MEZfzXb49cJhWW3cU_5uUMXseO6syuZmNRRGVFjEmYbXeRmR4WvMUd17w5iRlP2wscda-tB208Cz_DiPDy-Md-qxRdvQKjNoinhQ8o9YqMBZJhsk8IKlOppTgmtIvXhOYR22Xz6Ct8M6lnYQm5InkQTGscOq-gKXNOFeS93OBdbwMF9tnNt0E8fvcI-nc07tQoGfA__o6z6yDsxPedZQLP0TAP7n0nZkmRWWZwboSMFz4TrG9Ao2CphDE3QTWCkqy_t9_o_3h0qOwVThlFmS_LA1poM-dtarhXyvEi2jo3QlL5njlylR4pK5AH0T1xjDAdom-RfLHpc9a6AhI6kaoQrDnlYPwxsUi2tLJ-E7cd-bItlIIIDTKYsD3DC5eEYDnOHN4GNjg71dQfm_ZrytbaWsIm-C7PuDKePBhVaw-VDpxv33UtpBAOx4jMdvU0GrWTp1djAVoNqgb_QVTVpCBqUobB7DMkCQCOtdzZ8WS95BIJeCX8_RiAx9_z5_EeEdlTV_-c-h9nFf3fP69yOniOMFDoz0h0ts1-1Im-zLXrnPmsZ6LC8lwwyPny8XCmLISgNRBx5l_-VCorG-EEuNQXTBYgeEt7algI7kk6ZQXypwO0T4h-603AyzO_arDAsajDOVTfXoDzXdKSO2P6BsKSeGHsGSHzpYwCgIMCXjngIrsjr_YNzmd6G17yLu0veRQBg_12JghvUGByrMFWeDSB1zVyQFbjbJALFoiS8rZ0pSeEfZQIfXyILsHPdgq7PyKzpaR1g_ZiW75N80YJefuEV9KeGb8nmHIKXlsMuvrEUk8MVD1iW7Eplmveuy3mPYAQmbau56Gk00K1Ctmxfm5ED9i3uA3gIysqRi-WnspWABOkw6YwtTRpaCo-lUY4FO-59aoHuxUDw7gOD2muKTTQ6Zvi1JPj-KMlwyzsj_gkM6kAh2ruFE2ZLXIyaI_wruyQeoCpBMyRvUz1yRYe3xOBUEvzus8DUKrdeESZleAyAwEi_d8FF6r3jrCKGqGXi-xnJp6mJwmxCyL1g2ykjYsdYpTkbVKegbkXLkFGrnCPH6Mv_garPFCHgyu_OYggcOx-Bho7k_EU86-kCllFxNKYm9G6fHE5mrU1MiSBa6AA3dCwbpW7OLlqPxVfeYJyD7Ltb9O8t3tughmr-OnVfH-NPqng8YpunsJTtPB0gqmpWjl2Ay8j_ZglbE3r7XUgizr6dSaPhs5JMUB-WAjugtzfmAcS0QFZIefDD5c87K6Lqy9LALIUfEvB7y4VJVjtkxbg20WIGtCRARMYkkELQm8On8V4lf6sIICep8OSZZXI0fMR-u9rxTKE448sC03T2igTKSd62WuaZh_dImufxwUNQTLqir6OmMw5mHc3Qtx8f11Rkos8emnDBJPwsff_ATBAs3RzjXOlrirehqiS8EvdwO_hJumNmHCZ06b1PNxhSEsVC20K3c5riVIN21HGMEYxnmFfx2d9QyWH4SWdcvDbcDgJd6vIGWwCZXSpeN7XjLwNncfrHzd2U8imGsU2-jftysW6fuN0nxrLBbQ9GTwjUiIES7rv61RVlW9JNGHZANkmH0Bn7oMOM4ZJmAncaWRuVJ3V4LuPVtwLTkf_NYOtIgpra_o0L2BE-LQE_ykCrBIuUdHU3Vy21nwbxNKz2zq23aaSDUbbVxmvTugiR74w8ekjMOD4WgUXgjOQiS3MfwNatt1wlQr34y3xRdSDs8rCQUYvFeyWj1jIW17vDNozn_s26HboX1v0vRMwj5_UpWvFHinfp8IKQzRY1tabav9q26LUkEjW-LzbrMLXz1yBFmHW2j_Q_x_cvDVpMVjIfv-IeMya6xeilkkx3Woulm3XmaET2pareJB_pSQGASJ-WuOYlIInIc0C3gGB9yhdKIyLeoJRTufcXpihKlng7eM2TInk90T5PvdHINrjdJvZZPwlwvRw4rHN5Jz36e4aNtukanJZOT_J6_QVLnTwzO2h61sfM58DrX6hLAx9pqZlPoW5qrvPbsnCWFEC86QfFjwvFl1XzAHwteP12SMVhv8PRL05kzuWxf4522tbf1r7Llz4JtzhKzvOhJ98xlQnfzzEFY4R-KgHCpftrFz4D_XOZLPjHAY1XjCeXwwYWTA4io1Fb3siU0X9kPE6z3FNfDjfKcVeuGrtdI0lPHN79Mw8cJGmRMR1YhBYnD_GrTWUGYJM6XhDBN5DZxBwj-i_Pew05ffp_5ryhRYS7B0hMFOExaBwBHGolBb8Ym92Cd25CcMvYsnuCINdRLyzyCxGLB_BErM64OGl63LbFvHZt0dqa6KKN6Osney8BtGQnj7Kjsf4yHVv3j3g51-CeMxmH7HEHdPq0kUE7dDzbTCuB3csShK-sY3nWFzFgoei_0m0pbB-pyy1hty84WKBj-8sGuoxqhMEnJkIoURiwBKF5Sc9pX0jJqkpzSG-DvNbpYkHHzeWlufzAix9Gjm-4PWLBlfDY8--mTBVtiC09m1IV0AqGdxOs9hvXAEebnK1zIey-aainVf0xRSsUboXIQA1UPiii7vVs5iW2YtNRkqNYYGALGYCPDU7H248dJvU8W0b2oW7TQVrOphDa1u1cCPTcnCr7C6IczP39jn8ha0TchM40p19AWMKryjyoXQIvi31e-FQ97-V3YbNWLB0JAqsCrYoJpEu8ATZJDkqCDE1dHbM3NWQM9E7pF4sX23q2PjQjZSPw0oZ56ptDu1gzw9bC2IRPitWGEgI5kCYU02g59WvtwFU3rmWjXMCozBQnoAjpNRWTESzrMjB230G1XsxOX01JP0MxdaYGDIwS2zElybaL01ZzdjgrRslmtTeE-wQVxeCjJRZwZS4nZcfJtAJwGwsY2VJq3WJI19bXgrDH_y0wXoAR7YcBEQVP1NBOqwkWP54ThYA3Gy1scXNkDJCVOkGCQWDSAZU3cuDUQ8IpNk0qwlChzq_T_efq0MlVSWxc_Ucpr0mbuzdYYCupSYrlAFoFvltgyHgoqQ2ip89AtFiEs3GWvad3yeZm_CwPcYFhu7OkP69N3Op632PKDNOCVcNNpfeA2AOCQ6nITAGZkzEzNLtldYG07BVR-PcnEE1JnloMqnBGRZW35GukOrFskxm1xz-QiIhLYIzO2-Nx5nt0ZN1aGHLy9_pnRtYsRtAIHNnxupWBXBObeqELKWMx3Cyb83cA9-vZZv528TP-i1gX0Gh41wuQ-QV_vCrElp-1wTeifrBqyWBJL8kHdsDgXXhZ-TY1paaE_Zc32sEyJONf00Ym4rYPXSaLR6XieYSa60VIJ9ByvDv8oZaLaa6ks5M6-Mhtit9EmrkJJZyEjCrC5k1uSuHaRamZkmmg1ABmFhBMZquW7yJZYjjOZ-dqHKeQ7CVCTIHLF4v__aa9SvFW4vKAAZI7Tik5GhIUeC4cOnQEbpTk52mqniiV0V49msaXmUGmC7iR8KzogkGQnbadBMdRKs6Fjob6jcjKjTb_I3qvL00Ap2Uesro4InvEMPazhDAXH2lnLBh7eaDFwOcD4uKsxdI6MllslbIeqKyabeS9wPn7aY7bm87O-zigqw1S5WkJTfKDXICOZGfQljp-hBCqZUrTT1zTS8pPRl5u1CUGwhSV6SpJ6fAgp5JF9DseMJjApVVz_GFrfZvNBZ_TNj-RkpDdoXd5XwvIwP9dQolcqyCBFTVUYHTnW7BmMyHk_JmLy5QtN1G1zw0XFpYh4-Iv052vgQH1LINC5sXFOB_RalnHPya_Ct9XG5EX-iWy4pbQ2Katw5Q9o5Fk-RzAdVcr90319fIqVq7DhP7htYaFIVHnp9sVqFPEKdgxOlw62t0KIE2jRXuj0Y5TftPFml--sHKtcL3Q9R96YqCpI8mOeXUz2mgnz0aLwuQl3B3zKon-OCHnl03e9bOIO5zgSISujbn5b6XgfTWdLexZwdmvCOPWvybmkZj5DgU6l8YsYDMqFSB494NdWAZ_Q8-ehXYuGDA5gF0lLBRSrI8nqOS4aQlWfu05QtkHyd3bjxCH8dGIqLQI-iyQocC_-7_TxLduA8NWufNuS6vXOUS9RRtTgk62syt32sMTYj60HtoutcMAjjVhvMstDIij1asA9djLW4Ls9ZYKh4qWxv7_mn0Y9hiHy26iu7ETLFNV0yUi4rV3-KxreU_TcwHAOMUEToISwmwOSYLcSbEJZjWL0De7eXWXNlnW5ygMnfNu5m2mIQihDWVRbN97ARi48cBVqfOYJ0VwfBzSTkwuLecgFbe7Z_tYzJzeSMlppoUuDmO48GA7pw8ClFrGFE4rhg1696hQOOvBf7NBUY6F0ov0ev9pDiwqdmDIzkJBQhsUgd7OW3RaKOWFdVVFGotsUIKXBCEc589FpRdmCWvikuqrKKSTgY8JyPw1k9mC6fyOMxJgagUyvr2tKZpIr4OxrzG-uN85mq90Tga0CRE85UIMTG7c05njS1Ui_FbxZxoRwq4qPAOfk0BgZeNlGWpmGF5oFuVAFp7jD6Mn8mjWi61w0vUrQoNPwyMDXR86Y3orMiE6RVODbUWfvxBkJice3MORJCjEpLNTcBrbYYYDncpy4aGSmiw4iYKUJrZpKOfcIiz6rRtuuEA1Cdqu6fSxutoY4pDME75_zlwXxDHAyseOsovraiZygN5RClnjPz1_u-Tnm4DMwpYwza7B3xyuJ3u4m0q1SNmBQHp4ozUNNluEHnWswQn1jdz6B1vB4kwJdM6F8QThDPSWCQBhDDK2h22_JtWupuwuEl_ZDpv0JB60KgDrjSKeiGWjmwlhEiAyNK0v3THpOwYzdp4qYourlMklzsdCTslSEftdA_GTJ5x3sPLecwHrYic2Vzwgb2v1X2af8wp2PfprZZjtK9vlfPCLhSjiBUH4K1wizrI-01P6GdBkQKnm5BK5v1C39YQjw2FJMCZLEXzqfxc3jL5U3gupYmmIxxi4VkRSYfhjjHpQhLLTTl8aMr83HTcYM3jC5QB16XkgGFZaJg5BHGh0eT5Rhx85XxGCVBYdbGWp_3UjChSl8dK6CFhQVHBIOY99Y18Vab2LG0ov11ZSWsiQYzvPKni1bb-Ra-ouVeWgp4HqrRjEj2zdSrJ0o7O-blDBXmrYtrME316tFVq0gP6sajKfrZV7OI3mXrE9sQP96wz9ZWRI5TRuCkHSJ6t1eXozKIBshLcBNGwkhyMdE2rqAiW2HxwGF6Va0LhjJfKcQ7WfJcOUXN805obJadhioR6tYTAZDvLvWsDruXF-WtENn5rpIsKKYcoztVO9U-jeOD6Qu-NmSPz7MCIagKNLw0qtUf9EXwGe7uQAz7AzYd09r2MoZL6zgbydYz0uihvuphqPGcONoEtbpQRM--7b4W165tFpiqCZ0dEgA7fBHBpKnx8O6wLxKF4s_WNjF6j4Iksh1c1dAAcazR4fPXJ4yClXatpV7SrL32Al4sH3bMZQfSwin8k96rx1lHye0dab6pegfodIgfZv2-9ec10PC60qElk64qGiwIpFO5RidRggOnqwwTNRFUWABwkgIs8BL3VQ9pfuKRsfEPTLJwvrtpnj_IaQAi-wzxry-gYbXQggyzhUN5re5g3wFu2_qQQ_koOtT7AH5gOjUpexIY1MXH_5xRRo7KQwq9mGcDKt29GEXEcQrXvMNK6hDP9BVDalP7reQLu9i-VvyU1sQ2n3ppNNCASOs4coKMsedsxY4mcFbn2DfPiMDP52_2JmsgYqddMsWlmUIcp1sMu60CnSKjAA17C1vR4oe4WxREtWu9YWmv2zYlQ-yvdfe3SanH1e9Xn8AA9viEBOjke5RMKCxIL4EvFWWDTvsWB7XZM2EaA7xOYsrzznhMSibxLQRK7-kByC7n2c3V-DGIvWVEGyevG5Lt55djUrhwV0dLTIAm_FET3vCegFBFiQ624fmySMM6ZKzzYPcX2hn97OyTFbviCnlVe1aHp0R_-tLm513u3oRJr4o1EXZMm-vdUKBLjouKqvqwtH-B__mMYd6K_lR3tXSbsKmNsab6m5ReN7P8r0PmQQBoUmkh7V6VOeG8cEqmGKS5FfUQOCmi-MfCHFVto04IPQjO9mI9q3XynyUTKXMWwBbHGAEhI06VMj1dS683uT6DaHDiehUQyl5U3ipsBHNmyEgVay2c5FwTmu-fsJYy3UmreRBT9mqObUDoQmcn40W7mGhzRox6fr2JcHknTzJRZpJzO-AvjP1Lb6obHIdGJ4g1UFrZq09njH1Ep9riL1Um52L89F5O5B6eJ8I4lc1rmBYHxww5sHsIpNspnCpZ5GtIvjPhg0wVfHSA-KcIu_wz22tB5bDbEJouciVk2_3ypOa-F_zZOmucmevu65hzLiqhqZaw9fDPwzZIXu4tUUDbr4Mwi3Pq0aodkwSfILNrYf4UJepMPiIIiNAUCT_gkLfViFOBAQygqdxbMjfnlpGCFNm9RNfsDvrOB1nGSaS0g7HONuBmuWgN1mewTXVpjxJJejm1nJWfyTmi_lf7vcEkl2ff8QHkufbtOjKqtUu8a671wGUlUyMIYKbVSV_zhCCQN_WR6E_rPgODgzvx7n9-y6IwJWgyyyaMqkLGGH7WSL9QM0c-9s8fyrgn-OnfhADiVeThNmfb3kDwdL2YqXVwem-5vYTY_Q7y6Km5U27hHbTt9TKpBco1L6m5rxXVJMn1x8Drs-wgo5c0hfOmdzIo8qPdmL9VjJyIKzXQDUxUSz9ruSWFnYDkhcYyPuE8152NeYW9PrbA0nN4QcF7dDlgbIf1u_wvwfbw7P2PnxmXAnJauUrviwU3ppl4OANH7nN4LYyHuVQlr6U3ySKt7TELo1GjYB7QSPlVqQ8H1fP-vRpFMQaDX0SPKnjgusAdhxQznJLiBcJ95bXTBPglDT7BUCuq5PNEe5Fs1SZGd5UyYWKsmOtitM9PuhBlwBphA0vbph1b1MnvlfIVtLmYNMJeP3AcAUW90LEJmJo4hEnO1JzpDVzJraLLP8eCeQKMO9DoSJCHcu78nNI23W18N9eBK3lqzLK94lWcCF9LDX1zqOtzkG6aTr2A_Ct404yKlmVKBHmRTs8kVpZGXzsTnNVntoeH-vgjTd0WDR11th27KwG-1FDfGwTGSIqfPHgKDqmwd7U0LU8LzeWfBpeEFzNVAD7VXmZvqxAHhWtvGDtCg_k5EJ8kH0zvlR-aUkmYQAnQueuMgXkIISkC1dZ8bCOQpZGkA47kzIe8aZ5T5fbpkkqik2nxeH1D4e5M2R9O_HBqyKCR_1mtKxr3gPTrkd0z_D0N8Y2698y6teOo_zTyn2MZRnDEyRRaRAFf_s8m3rfELClSGKRKsje5m8028oOb4DyVI24fVkgW8yewi_kRAdCkwLH1wZxvwAd8CQS3B_iTf3wQSZjQRkWZiEm1xBoTE4VQQAKzGWlMpEOE0nKixcbxggrv0NoHm9DThgoaonkq1ITwggZzslI8MBF2FYmAvw-3GUqlc3mmfATPf8dJoPudpRjdOZ1qBDVpK7oLeIdW9C-5blYteoTGGSJP9Se_zY3keh4JFSPfDX6ZsYu11e0wYpdHRly4txhTNr38D5isp8Nt7pJjb7a55SRRJKlnHd-oSWuOh51ZZ03pVibzw8onq-CgNIVJXdbnebrmMbZ7HcX2SqvoRGymw-e4wmzmjezkR2WE6HGmi5BnabI8tEi0ekr1aWw8Ga9jZTywtC9gwQnSLTS_DOFWMtH1AzxELbt4qAvUwp5g_XJE7Z_FOiov4lKvrl_yhn5ESuTa9ACa1mzrjZNvcAMZ2CmrQH4bIKPWPVLMCrE-OIfHBKyAEGGYMz3zurzgekXAZJyT7NzKWqjAL5UIFZ1A0hQjIDy5B9q-T-2Jmw-qMAsDHeMwCXX_lksisyFJfXrydrEBEul25SwE352rP02L3IACGgCpldGDqkZKWjwyJqY_UY6fAhJrXEDvxCnSRFUMvORGHbnzeUdumWlq9CmCCXGUKTkmbp-w9rNDW3ir-jZppJFhBAEf7OIsDVBAQ1WFsAiviGy0ESMaz6lZCcPWx6jq6Y2DfUap2TJ1-guxNKn1pVRCFgyJBP7L9DQiWYAwpL5e7FNhiIvIrohpQEUYzaeDceYgMdojE4AkzCYnlnoQlZ5j1NtJu_mQG29827Z6bnJmpAI3DLbEbkyCPEgX_EEo_TF8lB7Gv3bkfu-OI16yOJYJeXmWiV3kIhFbaNS68eZ5mSPeY8jkYTX_gyh1mgo5Y-DA_hJRYpmX0bEgiB6OdjZEDd-J25ItCeM4umhOFtjGKu6kuM8yusCGZbeIla1ACD1uH9ZT8M94V-pRo5ovJ3ut3IBdGduxxLPyyTaabWffE8SIF_Ko8b7GywSFoAphn1jkUDJjM7yUynmfyJnI5X81iRSUHoePwyM3x-95fpFkA9caDiA8VQzg3NjcWWhzFh7dMgzXTS1NBh8nrTeQ9BI--ltiInPzQG8XHTS3Aw65IN264BV3iIaD6IqTbf9fz6jQUFbJ9T1LbFUxdqipWSv4OeZRxE_PUOEt-GsclMKDq_UVH-W1ncEHAbxElDjrB1PDOT7Bu02PJ_FFgCJ4dRslnUHSYwEusRXQ7E4LYAhTCgpVn7PHFoIEhha1evP-3pm36x8IMh3OeemzxzUTnXNuNr8ipOmtvgz_mezuVmjwrXeH91LDzKkBUrbviztlQfp-2wO5A7pbaeGSzK-T1Ic1B0-26YevKpgKmD5mS92isB-pscS0E-IVL6K7gCuy6GRGeREgUV6K28aVkDOkXRXCq0uXEpJnSWqs_z_LNrY_WuQhf5DsR34NMoNqD9VIUsIdOPUAKtMgtshrKEJfBmeFrrSppiUKaCOWI9ilX2ayqsfIvZ6AAruN96wluSpaZ27f29RdinehCxe_EnyzutyVG3GQ_2kiO0LsBkKipmAt2S57ywtZVoNUhP0WukSIAMnXDG6fSYRftNKiLeLEVyIEtovInucbEfUoO4jhCA_dCm7Ho0I1Pse57Lt7Up4mBUWtFVib69dm1YfjsJcwEiL-XcbncLAuxOPVjmENC3c77Uilbd_WyCRtGfPLH6VplZts-PMiAMwaDpIMazubOBkb6nvzszRXhCE9ghf80EtDDb7bQOIyf0fWFNKXnNXSYj2R6TZDbcsCV1Yo-6Ns8SVTCILhVGT0d1-oIEapC0hvcrejLnyeJ8owvOJqBWaPk_DV2HOeZQ-W4AuMZQEHdddufLMP_4ak8cg4U843qdiY_Jw1GqLUjiu9avlY9rl5dsQlwQieWwHaGaSuZ7bzM7veRJvfKHpX3I5NG6kF1pffChGPp1CY4itQHTAYDhIqbtr8eJ09EZh2HRkrdmhLnnJIWvXjL1vXVrB0qt4j-8ZTMfJOw_qjQFqr4sLCrgn8HdMBZGfKQ7X3n5Plkyuz3oImTu1ydMS4xkJFqtKglly0nJ2DR6rAWvJXkoGRI1GMn8DNpLL92eM-jbup_bF4E7zRwXAYFobUv2DfIWfaqvQW9kPEd3uh0vkePgxJaF38VH_IqPyyU1sVSSsLhyGe06O5aDMhB5I6vwKdiiFUygb-Ahc60LRH-jN-hKGmAr1Gs-xS7m5nr46CheSYcdxuEiVenWpKYHk1lvu6VtR1ZVJnScLmcaGstQDassBJZonH0BgBqf-PxnBceqPYtr68o4JZ47BnOjFyoNz8OOIGwrF8q31Ya1cF_8nyTuFtZcLbu_Zt4yVTgjEMKF83LymRcvbUFevS2ZPHhZs8zaBFvZa96_bHGTAtPZD6C2SgtB2CKUSvaCpdPknM9lwi_5J5nEoOGc4KSPxHnIW2PpmoGK1bqKPg7EMOctQoOPxIXSw_LH4b4--lVENVWyr3yAzINDmIYQOGfP_hlTGTzx76fF41gt0efWRIgj1gWBVp5coV7Du8dFNLs8o1YlcHLPooC1-OkvV-3UyszRyfIrtklocEg01aG9tqxltKDO9wgJPH-ONC1vyGNt9C7AGVmaQ8LVWkPx6CbbjqH_Rjj99Nv8_0JyH489JNPyjLHJvZlyOrpoK_kLwkc3evRJxODNKkhcUmFZvomwXwv5YxwyxebKPf3SSKw8U6q8VxHaXoSUB7TI0OGoG8s6agScBGs4l1rWL_L4-qOPPl8kEh7-Kjecm-egb6uKKtuz2MY3K3rNgOYyD6ByvvtxBGX08Ec6oKzyWm3lQ9Zg-a8Jub4PrjKTlCOXiGg1aZfOI_PIbXkDMm2vwjbdWlrr_ASocVCFqAxWy1nq_vCY6IaKSrDCAn1GgIH-i16K1bZwGccNpUQWAKE4c8koObXgSD-5ujTfrWVAKFCh43yKCLvc6FEm0AqKcFt5QhLbFtiG8unlRtDqXru4bXqjmZaBsHXqsiG70Ic9mGqlR-mWzS_AsvKJh73XempgBNH_qnaAKISjFuE9WYO7BqG0FvLcz_Q8G18ADa1GPcNM6xq1KIlTbOYaqLJEYE1R5NuQWezMvSX8IOwCXRZOl6ObHDbESDp-REFuvYlYwS_EMygYy14I5wBODIgrjWsrAhQe-GWyfknU21kWy_dTgU20Bp44nU60yuuG9YdEvacQFmNCd6e6T7eHetpI18nHTnXP1c_3SZ0CPrgFyGyWXQyk1hcag1HtsJfghmWz9_u6nAmhzb-_zswh6Miaet8Rnl0pYkFa_y2FTWdJ2CyVmZP3aIU7qkE-moPohF6wiEhmNN9DPbJmuMYuPWBFgERAuHmZTBBtf2X9ti2Qy85ejh-kBJdEhh6X4HHlyQKFGVOIB4iRBc2pjYPeDTLM2kkM0jR2yKYHs-kArpEiPuVbDlp-KHFjrtB7GBLaOq9kXFvB_SJArs6R1qkDOqMHb39CIpWBsU6br2DXEbgQfYUEKohNSswC6XAUiSwDcSpZvVnOuTxbJGVpC-p9u6lAWI7L6WvoBqhp9jyqSyoPOwDhhnOD89bXHILorzAVrcKqV84PEpZWPZG4Uy08aVP36cX0m1Yx4Nk413N7ojFv6XBF1Pj8BdCPfAXdGvKHOiCU71AWg4GTlnXPfHgufKvn_WpYgBlP62q95oAr0WJ8yqRVrlL0VB3URYTOH4lyqyd6-rop2HmVe9LYBcUOE-rC5J7UUD5eP7pvkwTGy75HtOjKSZlOAOMJpQm5guC5FWbnwgs61PR8F3RGMcEJSxk6kirh9RsCCSehLvfD6LQlG2Xo1ODRhx0yvURcGaukpR_c8O9-ycWOD2VtBVBcuwGbVRb0nLpJKxq7z6tMu5LtMDmGQtbzdDFEMkAP2Tvr32pW70ZvbEgYeRYt8YatVdnUZvOJfiIt-gZbZ9LcDz4lv-WzsRRJ_G8h_yhLYQE_YO4W-VViHGgp5VV-a2MjRnfZrHTh-7rb77UPTaqy2jvKYa7BWv33W_3-LUu-E4DpT26-Sqq9qWuERUMJ8q5oQyBXirZFffqwgFpnMLcYxHGNmrcs7IfbGQ8k84zAGi94jypJcFExMog3698IIUXJsEMYUELkxqVfvy9xz-YRvrJKTuYeX6s9lseuPL9Lo9DZ3KjrGBTr6rL8bh0pU2aDGcrGvXa-_jG-0HpEAojR9Y5Uqe2CKSB3PtgMsHAzJn9NrWBnRqKwERC-cuFS1XsD75E25bkYhJyg4qLGvof37L6IMGWVZql2S9kmApHzwqSa1etgLettLgqYXYdTidvp8QtAOB_knlcRS7E5KMsShH0h7up3yHojiw-V4Fza_6XLPh9v7F6h8F18MOXUQWWyoiQpRQF6pP7Sa0bcJiY8uUUkyaK7d79MQ1uc8wvCNW4Q2ox3oju3_C_jHX6uWdz0o4yFyNGGzg7pJMzhogDb6tG5zYKp1DUamlA5sr0F-HST-xvxOfujoPOs0uR7YWoomtE5bctlC_Swd_gTrVpIx9xP5tz2DERdwn5inYT-1tdU01_BQXcJcZWssouQoQVehee2K2y6xpgTlAe4BTH2npV08nnE_izwVq63ouIep-LerBo3Ekn4xBZZHoTJN_2rlh0YEflTpbNMhHb9EP3Yl2CEt_hp2Yp_1NXfrzqufZi_Os3mOhvXjvW9vijHgtogiWur6mSAhZsh3ddhcqTp-L98LunM9OBrpJQaHvtTj4MsaxiKZSSSomkHpRzV_bNlweARUu4aqqxK6pWxWTtBCc3sn1mZXS5Xbg7wC3Knwp8ay2GgL40PcAhqPKvHdcQPyqfxGykbGQYzQV3SyTGK60IFsnant8Frb3AzvquHAOHB6BsjjeyvWJh63WDSLCMs6_y2xUg4v0bVG19K-pb02ByuZfHh2pa-opu_c3jUXlzcnrl3JMicOxoqZgIuQ4X8SHvktLps1DQNE4XMPcZk9zj700u-rc0-7CMXIbzBAsGcmtb8BeupE6ekxwvPNnTeckrgXaZdDN6Y58ZYcJ7jX71JDoYK3Og-K1GZze1AoA_bl3WM5G0ixypOEqCMIWd9TfuFqbL0uUM7PBBTc3G0T-1BxQ4NeEDjQr1oFWM96ktDgJUxK7BDoLdytBRuynJP_JSH1N-SbwL-i29crACu2sYuqre5Fx4jYZH8IVgwdFtiKn6vZPwAk0hxuUwG36_tAXzHbvX2jgiMvzbV-Y2p1EK4c44265vCrFV92MEjLZifs-cgpIt9AneMh-q9ELKj0J_dEXxvqJ99oVuv46lgiQZZ1TckuymfBcQAtQSi-qX3Qn_tmpOyPiuKkQ9moFKo4pJG7ylUTyFb7bbLZS33AKpHruncuw9yUu7Jww12FpzX9pUDQ91SsrPhe8lVDiJhttKcgAyO9Y-xDqlVB1Cge0dskbb5WZ-kXAbfGMRSNJwQfe7AUyXLrzr87i2O5GeHlhLQalmcpAlgVCTCFoFmAnd8xbD7eVCcYvVSh7dDx5JmP31s2dHX3sVTGCBAPxKaReTSWvO3J_JYIvzRtqxHCoyMrKbJscrP4zcsZvjC44K9sTP6StneRm9sOOMJUcj0MD4ppDeOFvhD3lWB_VasHIFee8VSjaQigyeb3bmqDyQJFlRjovjROz-v5QscIcj0nkwexEgaF2x77l2mzSpd7i44a6yRJMI4GS3PmSiM6ta2GTD9umMBNkTcQosxdrz2MwwsGiO1nW9r6GQL_IYOTqI8hPKaq2f9VrlH2SA9lfRqJ1NHAhmlnA04d7LdSGYiEYR1uKW6tb2rSf4BrBjI-dhUzEUwav7M9axbggcVQlyAEYfrCVK6Osxbf6eVzGBBg0I0rsJJXar4b9SAn4eCW6fk5QXxL8FQxLojlZaFwWdYDsRhGZh7smXL_Jr83uKF6coGIwCZi1hgchx_lc37f02N5TdeYou_skh_G1SvgHmXeJAF9MWvoJFNpUMH0bhUITSrO5Mm3HRDaRUUTsUkNxuvBau3uWKgS6RIlRNLR9ejZyIuHCWynXiucTCJsT3pDnQozX7w26La4SQ6q7LQV2XK1PEwrXLTxTuSuCkx250wLtTh-KDU9YDVYvDslSqMwFJiqBhjKwTnqJ90Jy7bnxV8RWQlqws2irWEfRtRJr3HaO1rxG0fOpH5puV1R8CxuC0s3pbOrBu0QxnDztHUwPOO6Q6LVvAktUrYUvADHkhqtWsF2nTCb759C14IbesqtN8HfBcY8deEod1BCP05l_qwmMKxsONPIaNofBLdIEqOGkRf7n5BN6IRDsLYFZSY8bdpvNSjF5zXEli2L5uVzSnsM8SelQC5x8hgG-EIVNIhkWK2E1Hmt0gn7uB8MgA7qHN3BVMV-S-iN3FaMpd_wFhgwQOY8pFdbVsy8fKWlWUcTvHJok--WLQZaRPaZ85rbXlqgndm1k9RcOW46YzObQmpL2KdaU0RaMMZgqvcGOrhE2smbBa4QtbiV9tg-6PvTAiKWIBwfUQ007HgnCm8ReBQ7z8hA-n0slfu6HuA-egM0pa5p3vaXjtpGjcyO-UhAVefNb7Ml7z2OKlWZCgIM1DVCYbye3fGInY4zzHWmlSjUA9F1tgh25jhxedhaQseHP9Wq2xr1aeBn7m0giq5G4e5RLBJnT6KsqgXf4uccJNOT6Vut2JfjUwfB4pB01NoqRmM95woqHEB9e4bCuclKgMz_KHOG_V7Qri_5IlJ_yn8Yg_IzOV3PbWThe0354JNwhwFhmoGFTKijr32i9w3IoerhQ1cj6152F7CLkVz3YdwHrIXElC5Klp62xztr4lIupd9mToZoe2-klntqpnvPudAWK7nDOZrTzY4kZbE5htyrqKtMdEBGzrjdX-PMscGTbpP9fqH-F4aglPpOY0isnBNtg0AIH1P-PSTlCApZhGXB5IUny_4LfXdOjrmBxzqd_WubUjCTnROJwCxwOf0XosEZGVdOkcbfJSBQF-2J1G95FdtvhiucJkwK_a8-GMv_3SvFlvTJV_K_n1gtIzafckJvrrVm5XFrXnEMm2KKTr2xMwcYkePJFbi24iPlJAhBRoW6vHf7IHEZtm7hfNR53xwnFLLVh7Y49Otnqgwtaii1j8HdnoZKw9zYRcAgNhqFKN5R7-UtmOQ9ZG8kYjiaYcDHGm8F7UvN9vrNE8QR5wQ51TJM8JyEx4EThrszgcL5PYXCzRgIkWlNwlQM--Ru9F9sLg_jnGJKJPlM6N8X4zAmZmdA3fuKHRMU5O1pkVW7FDVzCTt4faO-pG5ViTwm5SHgxxbB0p4sj_6C60SuQrutf6-3jgMA7-I_zLyxQXHuzAuPqBe0vZJJbTbaOrNgIYrAdVhAHEhxVJIB1L2gr9sswCJLCfirt99pSFnRBlVOS_MmrbtwnRYxwD0DHpKM0uovY8VetJGtFc3Ftt13o0EyRqI2pZqVKrhxzw12VTHOWX1lBjPavU57cvCRIFntuZGnXRoNUe0spFaxOMT6rdbe_3jfjMJi3zKtWytGG1V89W-x0FVp_KfnVuGuuctlwosHATaepuvH0dfcFlIdijz0JIedTLIjul87s5lmA7MgdXast6E6BmfZm4kBQ2weGcxbKxeKWyfIp3V9-xnXLsnHzakr3id6tLHviXAPHyH3Sn8YOM28gXrd1rVBUYAFl2O5iPnv9XlqBX_O4Qet1WlB2WQuaWMKIxFsYWPPBetYuBfqVgticySQhoRCzNMWmIPGTYkFn9wcpkUNhgrRxc2gK7sRdrVHtPrYVKxTuX8hK2AevdNKmehiPdgrD3bczg-UAq5V991yxFKX6cWyy3kSOB4ecnrETBh379y3ZKkJXPh4gHotNLB55hMtJh2QbysKgDChVpBL6oW5m8NgGtfAlizvxtEG7RiSrWGU9pvihslemq9WmFYE4JZLTzRtsXA0LlzV_qa7-2kijRs2m_1EZaC0aTbifgfAYNP6zayXyjDv3RZJ6XUHFYZGbYp1hPVrLG-k7FangMnLq9pu27t48tzFuqUoi5mPZVjVm6lkjNOqtK6zUXTNuV9XDbN8jZ64kKumyEcV5mpsr6ZICqq-qLr6kDg1uNS4agqmEt6Rg5SfaZB8lE2ZirQLOOjrhJpfnTUC2Oj1Y8OWjdtEQAHMvU0UZGYiNHMjpbTqQ2ggBqfnoLkJlDiuVGBMN4SdytYWSSJcoT2fd29LrF6K5Jlw8tmqh8GNRYIW0ISK1CniqZF_GmYZUWeGqxmfHmNx35RWE4Js2A3Nl-ehzOuagwjQgmz-jvScsgAsVVcNVYYH2Y2jpo_R079PZvtca6Mxz4hWUlCXv0prEvXp5VrNXMd6LYlPiVCabTbaOVrOTG5Je3uuYxCiIxSEsdiqsq4TtDJj3bDvuSSOtt6E1B2JQY9r6aPS7c9PmOOHA0CfiVltD2MyOP3YnftcdF5x6diuSLjcKrjQnift8mtcZ_yGh8M735v5ZqCEBVP-J7IY960LGxCoR3j77v5WT1nG4siv133nR7DxfuKOUR77BpyIJ3Iw2zshypXgamcIORMYotOYUu9Hplc1WOFQgfLeir5p1TvZ2MNaKX3Vn0ssmhYC_glwfo288Yheynw-rTaM6_nQZD25R45U95vOv9zhDzkwoEI05vrN7h_rDNSYdrnuiMIPMTcSaG4HGYFmsfPLMEQt3uMZtLAKcS0Akm0ROUrBMlqZfzzBpKRZk71EHWSh2r7sBe8_XRfQOg4mFY9LiuFhqEtRlFxnhQZLkFqTcEhe3s03BYYUVeDldZUFOUYL3THTzY5I7zTdddfsosyEBe7D6HOkc-TCwpmHhpV7JdVLU30ERYlgKeWcmKbq1JUicZX2ZMqGG6h7yrkkYIacwDlD4UO8ThrEDV-XevmnHPvkF8ERC-gQMGxq63kzZbt7qwvelPPt7uyTt95TZYaB_oIxoYeDkTlSuH67CtuMsxnY1Nnf7CLMEaO0fBPmo5vfXLWJfvg-ZICF05e1PSulVFL58_GFI4XsYkO_YxinD30e0P-4o76CTkZU9PaiF60exHmb6oViCsDAiWEv8a0CyZ4KvbTUdcWU7L6BXW02tGP9b_coKKvYRRl8sOVvAzMP3ipCmMWUuTh-ctlRbBh4hhCdby-g_AezqngBbMOpJp0ZDsnxIuVMowUbpto6DE6VsUcjHaK30G5BEmZtcohflplr1BOWWwSY5EziBneptYJfnSf9w52NhqEE8COrUnmGMFy1XaT7nlfrFEx9BsqILwtuNk7niNDmwhvGv2ygi3gzcrghK7NHi4ZbkNjsFt9cuVqtTnb5rinfHpxhrLRmroKWxQXbseCm8sB66Pj5rrnU3krrGWFz3YIJc_MFbS4YXeuKPKgVBJX5yWg3_rAp7tHEUKak3-955PwmmF52LZGxX6DJ5hILK7NuT1BRMxvJMdhxo9WxciIMgNYJ8_QbhAle3ElFjcQgfYfV11Ujhve0uT00mSj22dFvvzzE1eo5Lfzm62SzGzada8CaSRlcQOJbEHt_BjBDRyxdnhZX7YRZYLSwLI3WHjDErdlydHzbDHeIrru-fMlETb5K7jJ9dAS5odes7SpEyLB_HhHn5V_WrP7CM3NwrW4qS6hMe2beIXI2oXyLIH0qTjLcBq_y3_y_DAFS8Trh8g9_URLy8UG-5MWZL3ocfNmSwYhxHu97RA2IKph4yS9MkMwVKLDdV4ahJO2sKPFc9AUPfD2xe7vzEtMToLNcC5HxKSlXZDW0TV5mxWywT523775mb9NC00tgBtur_v3zSqdbc53J_kQgEagEINyW_gmJn5iAMgIK8H1ZgaDX6nWPOyq7PrA7bARwvsN_2TOp_N3IuwRbpoPxTGtrrUPGkZ60BytBSKKtzO3gdxFfgAGBI",
    "summary": [],
    "content": []
  },
  {
    "type": "message",
    "id": "msg_0692ec3cf987cc89006afb8775d3f8819599bc2d850ff61bfd",
    "agent_reference": {
      "type": "agent_reference",
      "name": "k8s-incident-investigator",
      "version": "7"
    },
    "response_id": "resp_0692ec3cf987cc89006afb8766a4d081959ae930969478f280",
    "role": "assistant",
    "content": [
      {
        "type": "output_text",
        "text": "Executive Summary\n- Scans provided: Trivy (container) = no HIGH/CRITICAL findings; SAST = none; SBOM = excerpt (truncated) showing multiple OS and library components (Alpine packages, BusyBox, Jackson, GNUPG, libcrypto3, etc.). Truncation noted.\n- Immediate observation: No blocking HIGH/CRITICAL findings reported by the container scanner or SAST in the supplied data. However the SBOM contains components that historically have had security advisories (notably jackson-databind and several native libraries), so a full SBOM-to-CVE correlation is required before safe deployment.\n- Recommendation: Do not deploy (NO-GO) until the full SBOM is scanned against CVE sources and any discovered HIGH/CRITICAL vulnerabilities are remediated or accepted via documented compensating controls.\n\n1) CRITICAL Vulnerabilities\n- Finding: None reported in the provided Trivy HIGH/CRITICAL filter (empty list).\n- Interpretations/notes:\n  - The container/image scan shows no HIGH/CRITICAL issues in the truncated report provided.\n  - Confirm that Trivy was executed against the exact final image to be deployed and that its database was up-to-date at scan time.\n\n2) HIGH Vulnerabilities\n- Finding: None reported in the provided Trivy or SAST outputs (both empty arrays).\n- Interpretations/notes:\n  - Absence of reported HIGH findings is a positive signal, but must be validated against the full SBOM and current vulnerability feeds. SBOM components may include transitive dependencies not detected by the image scan if the scan scope or DB was incomplete.\n\n3) SAST Findings\n- Finding: None (SAST array empty).\n- Interpretations/notes:\n  - No static code issues of HIGH/CRITICAL severity were presented. Ensure SAST configuration included all language modules, build profiles, and the same source tree as the build that produced the image.\n\n4) SBOM Analysis\n- Data: Truncated SBOM excerpt provided; truncation acknowledged.\n- Notable components present in excerpt:\n  - jackson-databind 3.1.7 and jackson-core 3.1.7 (Java JSON processing libraries)\n  - HdrHistogram, LatencyUtils (observability/perf libs)\n  - Alpine OS packages: busybox 1.37.0-r31, alpine-baselayout, apk-tools 3.0.9-r0, ca-certificates 20261020-r0, libcrypto3 3.5.9-r0, gnutls 3.8.13-r0\n  - gnupg 2.4.9-r1 and related gpg components\n- Risks indicated by contents:\n  - jackson-databind historically has had high/critical deserialization vulnerabilities in past versions; presence in SBOM requires version-specific CVE correlation.\n  - Native libraries (libcrypto3, gnutls, busybox) and Alpine packages can have CVEs affecting runtime confidentiality/integrity (TLS libraries) or local exploitation; these must be matched to CVE records for the exact versions.\n- Truncation caveat: The SBOM is explicitly truncated — the excerpt may omit transitive dependencies (e.g., tomcat, log4j) which could carry high/critical CVEs. Full SBOM scanning is required.\n\n5) Risk Correlation\n- Current state:\n  - Container scanner and SAST report no HIGH/CRITICAL items in the provided data set.\n  - SBOM does contain packages that require version-to-CVE correlation; missing this step leaves residual risk.\n- Source-of-truth/verification recommendation:\n  - Perform a full SBOM vulnerability analysis (SCA) against US National Vulnerability Database, vendor advisories, and upstream CVE feeds for each listed package/version, including transitive dependencies.\n  - Confirm Trivy scan targeted the same final image and that its vulnerability database was refreshed before the scan.\n- Pipeline control note (context from project knowledge base): The CI pipeline has historically gated on Trivy and SBOM results but may have a temporary exception in some cases; ensure no temporary bypass (e.g., \"|| true\") is present so that scanner findings will block promotion when appropriate【6:0†source】.\n\n6) Primary Security Risks\n- Unscanned/Uncorrelated SBOM exposures: Transitive dependencies in the SBOM (jackson-databind, crypto/gnutls, busybox) may include unaddressed CVEs.\n- False negative risk: Trivy/SAST outputs are empty in the excerpt — risk exists that scans were run with stale DBs, incomplete scope, or were truncated before including findings.\n- Supply chain risk: Presence of many third-party packages increases attack surface; missing provenance or signature verification for artifact sources is an operational risk.\n- Runtime/OS-level risk: Alpine and BusyBox components and libcrypto versions may include vulnerabilities that can be exploited in container runtimes.\n- Process risk: If pipeline gating is not enforced (temporary exceptions), vulnerabilities could be promoted despite being present.\n\n7) Remediation Actions (actionable, prioritized)\nImmediate (must do before any production deployment)\n- Run a full SBOM SCA:\n  - Use the full SBOM (not truncated) and scan it against up-to-date CVE databases (NVD, vendor advisories) or an SCA service (Trivy in SBOM mode, Snyk, OSS Index).\n  - Produce a prioritized list of CVEs found by severity, affected components, and fixed versions or mitigation guidance.\n- Validate Trivy/SAST execution:\n  - Re-run Trivy against the exact final image with the latest vulnerability DB (trivy --download-db-only; trivy image --severity CRITICAL,HIGH --format json <image>).\n  - Confirm SAST run used production build flags and that results are not being silently truncated or ignored.\n- Remove any temporary pipeline bypasses:\n  - Ensure the container-scan job is configured to fail the pipeline on HIGH/CRITICAL and that no \"|| true\" or similar override is present. The project knowledge base documents this gating pattern and a prior temporary exception — remove exceptions now to enforce blocking behavior【6:0†source】.\n\nNear-term (within next release cycle)\n- For any HIGH/CRITICAL findings from SBOM/SCA:\n  - Update to patched versions (example: if jackson-databind shows a fixed version, upgrade to that exact fixed release and rebuild).\n  - If direct update impossible, apply mitigations: remove usage, isolate library usage, or apply runtime hardening (security manager, deserialization controls).\n- For OS/base image risks:\n  - Rebuild image using a minimal base (distroless or a smaller alpine with only required packages) and ensure ca-certificates and crypto libs are up-to-date.\n- Enforce SBOM-to-image traceability:\n  - Ensure artifact signing (cosign) and SBOM attestation are attached to the image so that the same SBOM can be validated at promotion time.\n- Improve CI observability:\n  - Log scan DB versions, scan timestamps, and full JSON scan outputs as pipeline artifacts to enable audit and post-mortem.\n- Implement an acceptance policy:\n  - Define and codify acceptable risk thresholds (e.g., block HIGH/CRITICAL; allow LOW/MEDIUM with exception workflow).\n\nLonger-term (process and platform)\n- Automate continuous SCA:\n  - Add periodic automated SBOM rescans (daily/weekly) to detect new CVEs in already-published images.\n- Vulnerability management:\n  - Integrate notifications/issue creation for CIV (critical/high) findings and track patching SLAs.\n- Harden runtime:\n  - Apply Kyverno policies (non-root user, read-only root filesystem), network policies, and minimal capabilities.\n- Documentation & audit:\n  - Keep SBOM production, scan outputs, and remediation actions versioned and attributable to pipeline runs.\n\n8) Deployment Recommendation (GO / NO-GO with rationale)\n- Recommendation: NO-GO (hold deployment).\n- Rationale:\n  - Although Trivy and SAST outputs provided are empty for HIGH/CRITICAL, the SBOM contains packages (jackson-databind, crypto libraries, busybox, gnupg) that require exact-version CVE correlation. The provided SBOM is truncated and may omit other transitive dependencies that could contain critical CVEs.\n  - A deployment decision without a complete SBOM SCA and verification of Trivy/SAST run integrity introduces unacceptable residual supply-chain and runtime risk.\n  - Additionally, confirm the CI pipeline enforces blocking on HIGH/CRITICAL results (remove any temporary bypass) before authorizing deployment【6:0†source】.\n\nEvidence\n- Provided scan outputs:\n  - Trivy HIGH/CRITICAL list: [] (empty)\n  - SAST: [] (empty)\n  - SBOM excerpt (truncated): includes jackson-databind 3.1.7, busybox 1.37.0, libcrypto3 3.5.9-r0, gnupg 2.4.9-r1, alpine-release 3.24.4-r0, etc.\n- Knowledge base context: CI gating and previous pipeline exceptions documented; ensure blocking gates are active before deployment【6:0†source】.\n\nIf you want, I can:\n- Provide the exact SBOM SCA command examples (Trivy, syft/anchore/snyk) and CI config snippets to enforce blocking, or\n- Analyze a full (non-truncated) SBOM JSON and the latest Trivy JSON output to produce a prioritized remediation list.",
        "annotations": [
          {
            "type": "url_citation",
            "url": "https://srch-kubesentry-dev.search.windows.net/",
            "start_index": 3811,
            "end_index": 3823,
            "title": "doc_0"
          },
          {
            "type": "url_citation",
            "url": "https://srch-kubesentry-dev.search.windows.net/",
            "start_index": 5688,
            "end_index": 5700,
            "title": "doc_0"
          },
          {
            "type": "url_citation",
            "url": "https://srch-kubesentry-dev.search.windows.net/",
            "start_index": 8047,
            "end_index": 8059,
            "title": "doc_0"
          },
          {
            "type": "url_citation",
            "url": "https://srch-kubesentry-dev.search.windows.net/",
            "start_index": 8436,
            "end_index": 8448,
            "title": "doc_0"
          }
        ],
        "logprobs": []
      }
    ],
    "status": "completed"
  }
]
```
</details>
