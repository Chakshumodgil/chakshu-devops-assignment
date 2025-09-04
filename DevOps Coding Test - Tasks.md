# DevOps Engineer Coding Test - Merchant Solutions - Deutsche Bank AG
**Version: 1.0.0 Review**

## General Instructions for the Applicant

*   **Goal:** This test is designed to assess your practical skills in automation, Infrastructure as Code, and Kubernetes management relevant to DevOps roles at Junior, Mid-Level, and Senior levels.
*   **Technologies:** You will solve tasks related to GitHub Actions, Helm, and Terraform. You will implicitly interact with Google Cloud services (GKE, GCS, Secret Manager), Terraform Cloud, and concepts like self-hosted GitHub Runners, external key management (KMS), external secret management (GSM, potentially ESO), Istio, Cert-Manager, and Google Cloud Certificate Authority Service (CAS).
*   **Setup & Prerequisites:** You will receive a ZIP archive containing this document, a predefined folder structure (`Junior/`, `Mid-Level/`, `Senior/`), and all prerequisite files needed for the tasks (e.g., `Dockerfile`s, basic Helm charts). Please extract this archive to begin.
*   **Account Information:** No external accounts (e.g., GitHub, Google Cloud, Terraform Cloud) are strictly required to write the solutions, and none will be provided. You can complete the tasks by writing the necessary code and configuration files based on the requirements.
*   **Optional Testing:** You are encouraged to test your solutions if possible. Feel free to use your personal accounts for relevant services (e.g., GCP Free Tier, Docker Hub, Terraform Cloud Free Tier) for testing purposes. This is optional and at your discretion.
*   **Solution Placement:** Place your solution file(s) for each task within the corresponding subfolder named after the task ID. For example, the solution for task `GHA-J-1` should go into the `/Junior/GHA-J-1/` folder. If a task asks for documentation (e.g., in a `README.md`), please add that file within the task's folder or the main `README.md` as appropriate, following the task instructions.
*   **Submission:** After completing the tasks for your target level, ensure your solution files are placed in the correct folders within the extracted structure. Then, create a new ZIP archive of the *entire* main folder (the one containing the `Junior`, `Mid-Level`, and `Senior` subdirectories) and submit this single ZIP file according to the instructions provided by the hiring team.
*   **Evaluation:** We will evaluate not only the functionality but also the code quality, readability, security practices, use of best practices, and the appropriateness of the solution for the respective level. Please address the tasks for the level you are applying for, but feel free to attempt tasks from other levels if you wish.

---

## Level: Junior

**Focus:** Basic understanding and application of the tools.

### GitHub Actions

**Task (GHA-J-1): Simple CI Workflow**

*   **Use Case:** Create a GitHub Actions workflow that triggers automatically on every push to the `main` branch. The workflow should simply print a message (e.g., "Workflow triggered for main branch").
*   **Verification:** Is the trigger correct? Is the syntax valid? Is the message printed?
*   **Solution:** Place in: `/Junior/GHA-J-1/solution.yml`

**Task (GHA-J-2): Docker Build Workflow**

*   **Use Case:** Create a workflow that triggers on a push to any branch named `feature/*`. Use the provided `Dockerfile` (located in Drive: `/Junior/GHA-J-2/prerequisites/`) to build a Docker image. The image does *not* need to be pushed to a registry.
*   **Verification:** Does the workflow trigger on feature branches? Does the Docker build step succeed?
*   **Solution:** Place in: `/Junior/GHA-J-2/solution.yml`
*   **Prerequisites:** See files in: `/Junior/GHA-J-2/prerequisites/`

### Helm

**Task (Helm-J-1): Install Existing Chart (Simulated)**

*   **Use Case:** Write a Helm command (or a small script) to simulate the installation of the official `bitnami/nginx` chart into a namespace named `webserver`. Override the `service.type` to `LoadBalancer`. Document the command in your main `README.md`.
*   **Verification:** Is the Helm command correct? Is the value correctly overridden? Is the command documented?
*   **Solution:** Place in: `/Junior/Helm-J-1/solution_readme.md`

**Task (Helm-J-2): Modify Simple Template**

*   **Use Case:** Given a simple Helm chart (provided in folder: `/Junior/Helm-J-2/prerequisites/helm-chart/`), modify the `deployment.yaml` template to add an additional label `app.kubernetes.io/managed-by: helm` to the Pods.
*   **Verification:** Is the label correctly added in the rendered manifest (`helm template .`)?
*   **Solution:** Place in: `/Junior/Helm-J-2/solution_deployment.yaml` (showing the modified template)
*   **Prerequisites:** See files in: `/Junior/Helm-J-2/prerequisites/helm-chart/`

### Terraform

**Task (TF-J-1): Create GCS Bucket**

*   **Use Case:** Write Terraform code (`main.tf`) to create a Google Cloud Storage (GCS) bucket in a specific region (e.g., `europe-west3`). The bucket name should be unique (e.g., by appending a random ID or using the project ID).
*   **Verification:** Is the Terraform code valid? Does it define a GCS bucket with the required attributes?
*   **Solution:** Place in: `/Junior/TF-J-1/solution_main.tf`

**Task (TF-J-2): Use Terraform Output**

*   **Use Case:** Extend the Terraform code from TF-J-1 to output the name of the created GCS bucket using an `output` variable.
*   **Verification:** Does `terraform output bucket_name` display the correct bucket name after applying?
*   **Solution:** (Included in solution for TF-J-1) Place in: `/Junior/TF-J-1/solution_main.tf`

### Integrated Task

**Task (INT-J-1): Terraform-Managed Configuration for Helm**

*   **Use Case:** You want to centrally manage a configuration setting for a Helm application. Create Terraform code that creates a single object in a GCS bucket (e.g., a simple text file `config/settings.txt` with the content "Hello from Terraform!"). Then, create a simple Helm chart (provided in folder: `/Junior/INT-J-1/prerequisites/helm-chart/`) that expects this configuration value to be available as an environment variable `GREETING_MESSAGE` in the container (the value doesn't need to be dynamically read from GCS in the test; referencing it in the Deployment is sufficient). Finally, create a GitHub Actions workflow that:
    1.  Initializes and applies the Terraform code to ensure the GCS object exists.
    2.  Lints the Helm chart using `helm lint`.
    3.  Renders the Helm chart's manifests using `helm template`, setting the value for `GREETING_MESSAGE` (can be hardcoded in the workflow or `values.yaml`).
*   **Verification:** Does the workflow execute Terraform successfully? Is the Helm chart valid? Does the rendered Deployment manifest contain the `GREETING_MESSAGE` environment variable with a value?
*   **Solution:** Place in: `/Junior/INT-J-1/solution_terraform/`, `/Junior/INT-J-1/solution_helm/`, `/Junior/INT-J-1/solution_workflow.yml`
*   **Prerequisites:** See files in: `/Junior/INT-J-1/prerequisites/helm-chart/`

---

## Level: Mid-Level

**Focus:** Configuration, tool integration, best practices.

### GitHub Actions

**Task (GHA-M-1): CI/CD with Docker Push & Helm Deploy Trigger**

*   **Use Case:** Create a workflow triggered on merge to the `main` branch. The workflow should:
    1.  Build a Docker image using a provided `Dockerfile` (See folder: `/Mid-Level/GHA-M-1/prerequisites/`).
    2.  Tag the image with the Git commit SHA and push it to Google Artifact Registry (GAR). Authenticate using Workload Identity Federation (preferred) or a Service Account key stored in GitHub Secrets.
    3.  Simulate triggering a Helm deployment with the new image tag (e.g., by printing the `helm upgrade` command that would be used).
*   **Verification:** Does the build & push to GAR work? Is authentication handled correctly? Is the simulated Helm deploy step triggered with the correct image tag?
*   **Solution:** Place in: `/Mid-Level/GHA-M-1/solution.yml`
*   **Prerequisites:** See files in: `/Mid-Level/GHA-M-1/prerequisites/`

**Task (GHA-M-2): Terraform Plan/Apply Workflow with Terraform Cloud**

*   **Use Case:** Set up a GitHub Actions workflow that uses Terraform Cloud for state management. On a pull request targeting `main`, it should run `terraform plan`. On a merge to `main`, it should run `terraform apply` (with auto-approval for this test). Use a Terraform Cloud API token stored in GitHub Secrets. Provide the Terraform backend configuration (`backend.tf`).
*   **Verification:** Is the plan generated on PRs? Is apply executed on merges? Is the state stored in Terraform Cloud?
*   **Solution:** Place in: `/Mid-Level/GHA-M-2/solution_workflow.yml`, `/Mid-Level/GHA-M-2/solution_backend.tf`

### Helm

**Task (Helm-M-1): Create Custom Chart**

*   **Use Case:** Create a new Helm chart for a simple web application (e.g., using the provided Python Flask `Dockerfile` in folder: `/Mid-Level/Helm-M-1/prerequisites/`). The chart should create a Deployment and a ClusterIP Service. Make the number of replicas and the image tag configurable via `values.yaml`.
*   **Verification:** Is the chart structure correct? Do `helm template .` and `helm lint .` work? Are replicas and image tag configurable?
*   **Solution:** Place in: `/Mid-Level/Helm-M-1/solution_chart/`
*   **Prerequisites:** See files in: `/Mid-Level/Helm-M-1/prerequisites/`

**Task (Helm-M-2): Conditional Resource & Secret Placeholder**

*   **Use Case:** Extend the chart from Helm-M-1. Add an Ingress resource that is only created if `ingress.enabled=true` is set in `values.yaml`. Also, add placeholder environment variables in the Deployment that should be sourced from a Secret named `{{ include "mychart.fullname" . }}-secrets` (e.g., `API_KEY`). The Secret itself should *not* be part of the chart (simulating external secret management).
*   **Verification:** Is the Ingress only rendered when `enabled=true`? Does the Deployment correctly reference the expected Secret name?
*   **Solution:** Place in: `/Mid-Level/Helm-M-2/solution_chart/` (showing relevant changes in `values.yaml`, `templates/ingress.yaml`, `templates/deployment.yaml`)

### Terraform

**Task (TF-M-1): Create Standard GKE Cluster**

*   **Use Case:** Write Terraform code to create a basic GKE cluster (Standard or Autopilot - your choice) in a specific region. Configure at least the machine type (if Standard) and the initial node count. Use the official Google Terraform module for GKE if possible.
*   **Verification:** Is the code valid? Can it create a functional GKE cluster? Are the parameters applied correctly?
*   **Solution:** Place in: `/Mid-Level/TF-M-1/solution_gke.tf`

**Task (TF-M-2): Create Secret in Google Secret Manager**

*   **Use Case:** Write Terraform code to create a Secret in Google Secret Manager. The secret's value should be a simple string (e.g., `my-super-secret-value`). Do *not* store the secret value directly in the Terraform code (use a variable, potentially loaded from a non-committed `.tfvars` file or environment variable - for the test, hardcoding with a comment explaining why it's bad practice is acceptable).
*   **Verification:** Is the Secret created? Is its lifecycle managed by Terraform?
*   **Solution:** Place in: `/Mid-Level/TF-M-2/solution_secrets.tf`

### Integrated Task

**Task (INT-M-1): GKE Deployment with External Secret & Istio Sidecar**

*   **Use Case:** An application running on GKE needs an API key securely stored in Google Secret Manager. The application should also be part of the Istio service mesh.
*   **Steps:**
    1.  **Terraform:** Ensure your Terraform code creates a GKE cluster and a Secret in Google Secret Manager (`api-key-secret`).
    2.  **Helm:** Modify a Helm chart:
        *   The Deployment should expect an `API_KEY` environment variable sourced from a Kubernetes Secret named `app-secrets` (key: `api-key`).
        *   Add the annotation `sidecar.istio.io/inject: "true"` to the Pod template metadata to enable Istio sidecar injection.
    3.  **GitHub Actions:** Create a workflow that:
        *   Authenticates to Google Cloud.
        *   Runs `terraform apply` to ensure GKE cluster & GSM secret exist.
        *   Configures `kubectl` context for the GKE cluster.
        *   Retrieves the secret value from Google Secret Manager.
        *   Creates/updates a Kubernetes Secret (`app-secrets`) in the target namespace with the retrieved value.
        *   Deploys the Helm chart using `helm upgrade --install`.
*   **Verification:** Does the workflow complete successfully? Is the k8s Secret created correctly? Does the Helm Deployment contain the Secret reference and Istio annotation? Is the Helm chart successfully applied to GKE?
*   **Solution:** Place in: `/Mid-Level/INT-M-1/solution_terraform/` (combines TF-M-1 & TF-M-2 logic), `/Mid-Level/INT-M-1/solution_helm/`, `/Mid-Level/INT-M-1/solution_workflow.yml`

---

## Level: Senior

**Focus:** Architecture, security, optimization, advanced concepts.

### GitHub Actions

**Task (GHA-S-1): Reusable Terraform Workflow**

*   **Use Case:** Create a reusable GitHub Actions workflow (`workflow_call`) that can execute Terraform `plan` or `apply`. The calling workflow should be able to pass the command (`plan`/`apply`), the working directory, and cloud credentials (e.g., via OIDC/WIF). Demonstrate its use in a simple caller workflow.
*   **Verification:** Is the workflow reusable? Are parameters passed and used correctly? Is authentication secure (WIF preferred)?
*   **Solution:** Place in: `/Senior/GHA-S-1/solution_reusable_workflow.yml`, `/Senior/GHA-S-1/solution_caller_workflow.yml`

**Task (GHA-S-2): Workflow with Self-Hosted Runner & GKE Context**

*   **Use Case:** Describe (in your `README.md`) how you would configure a GitHub Actions workflow to *guarantee* it runs on a specific pool of self-hosted runners (e.g., tagged `gke-runners`). Explain why this might be necessary (e.g., access to internal network/GKE private endpoint). Then, show in the workflow YAML how you would securely configure the `kubectl` context for a specific GKE cluster (whose details might come from Terraform outputs or secrets) to execute commands (e.g., `kubectl get pods`).
*   **Verification:** Is the configuration for self-hosted runners correct (`runs-on`)? Is the explanation plausible? Is the GKE context configuration secure and correct (e.g., using `gcloud container clusters get-credentials`)?
*   **Solution:** Place in: `/Senior/GHA-S-2/solution_readme.md`, `/Senior/GHA-S-2/solution_workflow.yml`

### Helm

**Task (Helm-S-1): Umbrella Chart with Dependencies**

*   **Use Case:** Create an umbrella Helm chart that includes two subcharts (e.g., `frontend` and `backend` - you can create simple ones or reuse charts from previous tasks) as dependencies located in the `charts/` directory. Configure the umbrella chart so that global values (e.g., `global.environment=production`) are passed down to both subcharts and can be used in their templates.
*   **Verification:** Is the structure with the `charts/` directory correct? Are dependencies declared properly in `Chart.yaml`? Do global values work as expected?
*   **Solution:** Place in: `/Senior/Helm-S-1/solution_umbrella_chart/` (includes structure, umbrella chart files, and example subcharts)

**Task (Helm-S-2): Advanced Templating & External Secrets Integration (Concept)**

*   **Use Case:** Extend a Helm chart (e.g., the backend chart from Helm-S-1). Describe two approaches for integrating external secrets:
    1.  (Theoretical) Use Helm's `lookup` function to check if a specific Secret (e.g., `external-db-credentials`) exists in the cluster before attempting to mount it in the Deployment. Show the relevant template snippet.
    2.  (Conceptual) Describe in your `README.md` how you would use the `external-secrets` Operator (ESO) to fetch secrets from Google Secret Manager at runtime. Explain the roles of the `SecretStore` (or `ClusterSecretStore`) and the `ExternalSecret` resources within or alongside your Helm chart.
*   **Verification:** Is the `lookup` usage syntactically correct (even if not executable in a dry run)? Is the description of the ESO integration logical, covering `SecretStore`, `ExternalSecret`, and the connection to GSM? Does it demonstrate understanding of separating the chart from secret injection?
*   **Solution:** Place in: `/Senior/Helm-S-2/solution_readme.md`, `/Senior/Helm-S-2/solution_deployment_lookup.yaml`

### Terraform

**Task (TF-S-1): Secure GKE Cluster with Workload Identity & Network Policy**

*   **Use Case:** Write Terraform code to provision a GKE cluster (Standard or Autopilot) with the following security features:
    *   Workload Identity enabled and configured (demonstrate binding a sample GCP Service Account to a Kubernetes Service Account).
    *   Network Policies enabled (`network_policy { enabled = true }`).
    *   Optional: Private Endpoint or activated authorized networks for master access.
    *   Briefly justify in code comments or `README.md` why these settings enhance security.
*   **Verification:** Is the Terraform code valid? Are Workload Identity and Network Policies correctly enabled? Is the justification sound?
*   **Solution:** Place in: `/Senior/TF-S-1/solution_gke_secure.tf`

**Task (TF-S-2): Terraform Cloud Sentinel Policy (Concept)**

*   **Use Case:** Describe (in your `README.md`) how you would implement a Terraform Cloud Sentinel policy (or a Check in newer TFC versions) to ensure that all created GCS buckets have a specific label (e.g., `cost-center`). Provide a short pseudo-code example for the Sentinel policy.
*   **Verification:** Is the concept of using Sentinel for governance clear? Is the pseudo-code example logical and does it check for the label on GCS buckets?
*   **Solution:** Place in: `/Senior/TF-S-2/solution_readme.md`

**Task (TF-S-3): External Key Management (KMS) for Bucket Encryption**

*   **Use Case:** Modify the Terraform code for GCS bucket creation (from TF-J-1 or similar) to use Customer-Managed Encryption Keys (CMEK). Create a Key Ring and a Crypto Key in Google Cloud KMS using Terraform. Configure the GCS bucket to use this KMS key for server-side encryption. Grant the GCS Service Agent the necessary permission (`roles/cloudkms.cryptoKeyEncrypterDecrypter`) on the key.
*   **Verification:** Are the KMS Key Ring and Key created correctly? Is the bucket configured for CMEK? Is the IAM permission for the GCS Service Agent set correctly?
*   **Solution:** Place in: `/Senior/TF-S-3/solution_kms_gcs.tf`

### Integrated Task

**Task (INT-S-1): Istio Ingress with CAS-Managed Certificate via Cert-Manager**

*   **Use Case:** Route ingress traffic for an application in GKE via an Istio Ingress Gateway. The TLS certificate for the gateway should be automatically issued by your own private CA managed via Google Cloud Certificate Authority Service (CAS) and obtained using Cert-Manager. Istio performs TLS termination at the gateway (TLS Origination).
*   **Steps:**
    1.  **Terraform:** Write Terraform code to:
        *   Provision a GKE cluster (with Workload Identity).
        *   Enable the Google CAS API.
        *   Create KMS KeyRing/CryptoKey for CAS.
        *   Create a CAS CA Pool.
        *   Create a simple self-signed CA within the pool. Output the CA Pool resource name.
        *   Create a dedicated GCP Service Account (`cert-manager-cas-issuer-sa`).
        *   Grant this SA the `roles/privateca.certificateRequester` role on the CA Pool.
        *   Set up the `roles/iam.workloadIdentityUser` binding for the Cert-Manager KSA to impersonate the GCP SA.
    2.  **Helm:** Create/modify a Helm chart to include:
        *   (Assume Cert-Manager & Istio are installed or handle installation).
        *   A `ClusterIssuer` (using the `google-cas-issuer`, requires a specific CRD/controller like Jetstack's) configured with CAS Pool details and Workload Identity authentication.
        *   An Istio `Gateway` for `istio-ingressgateway` listening on port 443 for a specific hostname, configured for `SIMPLE` TLS using a `credentialName` (e.g., `myapp-ingress-tls`).
        *   An Istio `VirtualService` routing traffic for that hostname to a backend service.
        *   A Cert-Manager `Certificate` resource requesting a certificate for the hostname from the CAS issuer, storing it in the Secret specified by `credentialName`.
    3.  **GitHub Actions:** Create a workflow that:
        *   Authenticates securely to GCP (WIF).
        *   Runs `terraform apply` for the infrastructure (GKE, KMS, CAS, IAM), obtaining the CA Pool ID output.
        *   Configures `kubectl` and `helm`.
        *   Ensures Istio and Cert-Manager are present.
        *   Installs/upgrades the Helm chart from step 2, passing necessary values (Project ID, Region, CA Pool ID, Hostname, etc.).
*   **Verification:** Does Terraform successfully create all CAS/KMS/IAM resources? Is the Helm chart installed successfully? Are the Cert-Manager (`ClusterIssuer`, `Certificate`) and Istio (`Gateway`, `VirtualService`) resources created on GKE? Is the K8s Secret (`myapp-ingress-tls`) created by Cert-Manager and populated with a certificate from the CAS CA? (May require manual cluster inspection).
*   **Solution:** Place in: `/Senior/INT-S-1/solution_terraform/` (includes cas, gke, iam setup), `/Senior/INT-S-1/solution_helm/` (includes issuer, gateway, vs, cert), `/Senior/INT-S-1/solution_workflow.yml`

---