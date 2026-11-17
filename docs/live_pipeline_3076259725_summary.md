# Live Pipeline #3076259725 & GitOps Verification Summary

- **Pipeline URL**: https://gitlab.com/itsme-aarjav/kubesentry/-/pipelines/3076259725
- **Trigger**: Push to branch `main`
- **Commit SHA**: `9c386b2529f974e3968fd95c2fde192349765a1f`
- **Commit Message**: `KubeSentry`
- **GitOps Commit**: `8fee48fa4c0c63d8bc06af813dfb649c255429d4` (`KubeSentry`)
- **Pipeline Result**: **SUCCESS (All 8 Jobs Passed)**

---

## 1. Jobs Execution Log

| Job ID | Stage | Job Name | Status | Duration | Artifacts / Output |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `18086209356` | `test` | `unit_test` | **success** | 22s | `./mvnw test` passed (2/2 tests green) |
| `18086209355` | `test` | `semgrep-sast` | **success** | 19s | `gl-sast-report.json` (Clean pass) |
| `18086209357` | `build` | `build` | **success** | 1m 18s | `image.tar` packaged with multi-stage build |
| `18086209358` | `scan` | `container_scan` | **success** | 34s | `trivy-report.json` (0 HIGH, 0 CRIT CVEs) |
| `18086209359` | `push` | `push_to_acr` | **success** | 46s | Pushed `portfolio-app:9c386b25` to ACR via OIDC |
| `18086209360` | `sign` | `sign_and_sbom` | **success** | 43s | `sbom.json` generated; Cosign signed with OCI 1.1 referrers |
| `18086209361` | `ai_review` | `ai_security_review`| **success** | 41.0s | `ai-security-report.md` (v7 English); Pushgateway HTTP 200 |
| `18086209362` | `deploy` | `update_manifest` | **success** | 14s | Manifest updated to `9c386b25` in `k8s/overlays/dev/` |

---

## 2. ACR OCI Referrers Verification
- **Target Repository**: `acrkubesentrydev.azurecr.io/portfolio-app`
- **Primary Image Tag**: `9c386b25`
- **Companion Referrers**:
  - Cosign signature attached in ACR via OIDC keyless signing
  - Cosign SBOM attestation attached in ACR (SPDX JSON format)

---

## 3. GitOps Reconciled Deployment
- **Argo CD Application**: `portfolio-app-dev` (in namespace `argocd`)
- **Sync Status**: `Synced`
- **Health Status**: `Healthy`
- **Pod Deployed**: `portfolio-app-5488d88454-tk7c9` (1/1 Running in namespace `dev`)
