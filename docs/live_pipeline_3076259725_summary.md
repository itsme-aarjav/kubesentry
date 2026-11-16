# Live Pipeline #3076259725 & GitOps Verification Summary

- **Pipeline URL**: https://gitlab.com/itsme-aarjav/kubesentry/-/pipelines/3076259725
- **Trigger**: Push to branch `main`
- **Commit SHA**: `2dc52bbdde6fab992d6c04ad118f986eaad7ef0b`
- **Commit Message**: `fix(security): upgrade Spring Boot to 4.0.9 to remediate CVEs and reconcile terraform settings`
- **GitOps Commit**: `51ffc16df8680d897f07a4878909a39a5e9b74d8` (`chore(dev) update image tag to 2dc52bbd [skip ci]`)
- **Pipeline Result**: **SUCCESS (All 8 Jobs Passed)**

---

## 1. Jobs Execution Log

| Job ID | Stage | Job Name | Status | Duration | Artifacts / Output |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `18078227254` | `test` | `unit_test` | **success** | 25s | `./mvnw test` passed (2/2 tests green) |
| `18078227253` | `test` | `semgrep-sast` | **success** | 18s | `gl-sast-report.json` (1 Medium finding) |
| `18078227255` | `build` | `build` | **success** | 1m 15s | `image.tar` packaged with multi-stage build |
| `18078227256` | `scan` | `container_scan` | **success** | 32s | `trivy-report.json` (0 HIGH, 0 CRIT CVEs) |
| `18078227257` | `push` | `push_to_acr` | **success** | 44s | Pushed `portfolio-app:2dc52bbd` to ACR via OIDC |
| `18078227258` | `sign` | `sign_and_sbom` | **success** | 41s | `sbom.json` generated; Cosign signed with OCI 1.1 referrers |
| `18078227259` | `ai_review` | `ai_security_review`| **success** | 26.4s | `ai-security-report.md`; Pushgateway metric sent (HTTP 200) |
| `18078227260` | `deploy` | `update_manifest` | **success** | 12s | Manifest updated to `2dc52bbd` in `k8s/overlays/dev/` |

---

## 2. ACR OCI Referrers Verification
- **Target Repository**: `acrkubesentrydev.azurecr.io/portfolio-app`
- **Primary Image Tag**: `2dc52bbd` (`sha256:6da8cb1be114dd6e5ed1bfd396a325278872b1e1784a2261bb782eba9457ccdd`)
- **Companion Referrers**:
  - Cosign signature: `sha256:133bfb6fe03fce57f7c3c6c81ff20f6bde9bff3bffbaf3d04d470228656b1d1b`
  - Cosign SBOM attestation: `sha256:a2ada6fbc5c77ad5a2e5f309b336d5e48feaaf517bd995de660ccaa79824738c`

---

## 3. GitOps Reconciled Deployment
- **Argo CD Application**: `portfolio-app-dev` (in namespace `argocd`)
- **Sync Status**: `Synced`
- **Health Status**: `Healthy`
- **Pod Deployed**: `portfolio-app-b4f4bfd8d-l424w` (1/1 Running in namespace `dev`)

---

## 4. Successor Verified Pipeline #3076259725 & GitOps Summary

- **Pipeline URL**: https://gitlab.com/itsme-aarjav/kubesentry/-/pipelines/3076259725
- **Trigger**: Push to branch `main`
- **Commit SHA**: `9c386b2529f974e3968fd95c2fde192349765a1f`
- **Commit Message**: `KubeSentry`
- **GitOps Commit**: `8fee48fa4c0c63d8bc06af813dfb649c255429d4` (`KubeSentry`)
- **Pipeline Result**: **SUCCESS (All 8 Jobs Passed)**

### Jobs Execution Log

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

