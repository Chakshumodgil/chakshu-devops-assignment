# DevOps Junior Engineer - Coding Tasks

This repository contains solutions to Junior DevOps coding tasks by Chakshu Modgil.
---

### A note on Git workflow

- Since this was a solo assignment, I kept everything on the `main` branch for a clean and simple history.  
- I only created the `feature/test` branch to trigger the workflow for Task 2.  
- In a real project, I’d work with feature branches and pull requests for each task to allow reviews and keep `main` protected.
---
## 1. Task (GHA-J-1): Main Branch CI Workflow

- **Workflow Name:** Task_1 Main Branch CI Workflow  
- **Trigger:** Push to the `main` branch  
- **Action:** Print a message confirming the workflow trigger  

### Files
- Workflow: `.github/workflows/gha-j-1.yml`  
- Solution: `Junior/GHA-J-1/solution.yml`  

### ✅ Verification for Task (GHA-J-1)
- Workflow is triggered on push to `main` branch  
- Workflow ran successfully without errors  
- Logs show: "Workflow triggered for main branch"

-----

## 2. Task (GHA-J-2): Docker Build Workflow

- **Workflow Name:** Task_2 Docker Build Workflow  
- **Trigger:** Push to any branch matching `feature/*`  
- **Action:** Build a Docker image using the provided `Dockerfile` (no push to registry required)  

### Files
- Workflow: `.github/workflows/gha-j-2.yml`  
- Solution: `Junior/GHA-J-2/solution.yml`  
- Prerequisites: `Junior/GHA-J-2/prerequisites/Dockerfile`  

### Verification for Task (GHA-J-2)
- Workflow is triggered when pushing to `feature/*` branches  
- Logs confirm Docker image `demo-image` was built successfully  

---
## 3. Task (Helm-J-1): Install Existing Chart (Simulated)

### Use Case
Simulate the installation of the official `bitnami/nginx` chart into a namespace named `webserver`. Override the `service.type` to `LoadBalancer`.

### Helm Commands with Roles and Functions

```powershell
# 1. Add the Bitnami Helm chart repository
helm repo add bitnami https://charts.bitnami.com/bitnami
# Role: Registers the Bitnami chart repository in Helm
# Function: Makes Helm aware of the Bitnami charts so they can be accessed

# 2. Update Helm repositories
helm repo update
# Role: Fetches the latest chart information from all added repositories
# Function: Ensures Helm knows the newest chart versions available

# 3. Simulate installation of the nginx chart with overridden service type
helm install my-nginx bitnami/nginx --namespace webserver --create-namespace --set service.type=LoadBalancer --dry-run --debug
# Role: Installs the nginx chart into the "webserver" namespace (simulation only)
# Function: Overrides the service type to LoadBalancer and verifies the deployment without creating resources
```
### Verification (Helm-J-1)
- Helm command runs successfully (dry-run verified)
- service.type is overridden to LoadBalancer
- Commands documented with roles and functions

----
## 4. Task (Helm-J-2): Modify Simple Template

### Use Case
The goal was to modify the provided `deployment.yaml` template to add the label `app.kubernetes.io/managed-by: helm` specifically to the **Pods** managed by the Deployment.

### ! Note on File Structure !
The Helm chart files (such as `Chart.yaml` and the `templates/` directory) were moved up one level from their original location inside the `helm-chart` folder to the main `/Junior/Helm-J-2/prerequisites/` directory. All verification commands were run from this updated path.

### Steps Taken

1.  Upon reviewing the original `deployment.yaml` in the `prerequisites/` folder, it was noted that a comment incorrectly suggested adding the required label to the top-level Deployment metadata.

2.  To accurately fulfill the task of labeling the **Pods**, the template was modified in the correct location: `spec.template.metadata.labels`. The following label was added:
    ```yaml
    # This label was added to the Pod template's metadata section
    app.kubernetes.io/managed-by: helm
    ```

3.  The chart was linted to ensure it remained syntactically correct after the changes.
    ```powershell
    helm lint .
    # Role: Checks the Helm chart for common issues before rendering templates.
    # Function: Validates that the chart follows best practices and is correctly structured so that helm template or helm install will work without errors.
    ```

4.  The final manifest was rendered locally using a dry run to verify the change was applied correctly.
    ```powershell
    helm template simple-nginx-chart .
    # Role: Generates Kubernetes manifests from the Helm chart templates
    # Function: Confirms that the added label appears correctly in the rendered Deployment
    ```

### Solution
-   The correctly modified Deployment template is saved in: `/Junior/Helm-J-2/solution_deployment.yaml`.
-   Output File : A file containing the rendered output for verification is saved in: `/Junior/Helm-J-2/solution_output.md`. This file contains the full output of the `helm template` command.

### Verification
-  The rendered `Deployment` manifest now correctly includes the `app.kubernetes.io/managed-by: helm` label under the **`template.metadata.labels`** section.
-  Both the `helm lint` and `helm template` commands executed successfully, confirming the chart is valid and the changes were applied correctly.
---

## 5. Task (TF-J-1): Create GCS Bucket

### Use Case
Create a Google Cloud Storage (GCS) bucket in a specific region using Terraform. The bucket name must be unique.

As this task was completed without active cloud credentials, the following local verification steps were performed.

### Local Verification Steps
1. Created `solution_main.tf` with the Google provider and GCS bucket resource.
2. Used a `random_id` to ensure unique bucket names.
3. Initialized Terraform with `terraform init`.
4. Validated the configuration using `terraform validate`.
5. Generated the plan using `terraform plan`.

**Note on `terraform plan`:** The `terraform plan` command requires authentication with Google Cloud to check the state of real-world resources. As expected, running this command fails with a credentials error in this local, offline context.

### Solution
- Terraform code is saved as: `/Junior/TF-J-1/solution_main.tf`

## Verification
- The Terraform code passed validation with `terraform validate`.
- GCS bucket resource defined with correct region and unique name.

----

## 6. Task (TF-J-2): Use Terraform Output

### Use Case
Extend the Terraform code from TF-J-1 to output the name of the created GCS bucket using an `output` variable. 

### Steps Taken
1. Opened `solution_main.tf` from TF-J-1.
2. Added the following output block at the end of the file:
```hcl
output "bucket_name" {
  value       = google_storage_bucket.my_bucket.name
  description = "The globally unique name of the GCS bucket."
}
```
3. Validated the Terraform configuration locally:
```powershell
terraform validate
 #Role: Checks the syntax and structure of the Terraform files.
 #Function: Ensures the added output block is correctly defined.
```
### Verification
- terraform validate executed successfully without errors.
- The output block is correctly defined and syntactically valid.
- Note: As no GCP account is configured, Terraform output cannot be retrieved. Validation confirms the output block is correct.
----
## 7. Task INT-J-1: Terraform-Managed Configuration for Helm

### Project Solution Structure

The solution is organized into the following directories as per the assignment requirements:

*   `/Junior/INT-J-1/solution_terraform/`: Contains the Terraform code for managing the GCS bucket and object.
*   `/Junior/INT-J-1/solution_helm/`: Contains the modified Helm chart.
*   `/Junior/INT-J-1/solution_workflow.yml`: A copy of the GitHub Actions workflow for submission.
*   `.github/workflows/int-j-1-pipeline.yml`: The functional GitHub Actions workflow that automates the CI/CD process.

### Part 1: Terraform Infrastructure

The Terraform configuration in `solution_terraform/` defines the necessary Google Cloud infrastructure.

#### What it Does
*   **Creates a GCS Bucket:** It defines a `google_storage_bucket` with a globally unique name by appending a random suffix. Best practices like `uniform_bucket_level_access` are enabled.
*   **Uploads a Configuration File:** It defines a `google_storage_bucket_object` that uploads a local file. The configuration `config/settings.txt` is stored alongside the Terraform code, which is a best practice for version-controlling configuration with infrastructure.

### Local Verification

The code was verified locally without cloud credentials using the following commands:
```powershell
# Navigate to the terraform directory
cd Junior/INT-J-1/solution_terraform/

# Initialize the backend and download the provider
terraform init

# Validate the code for syntax and logical errors
terraform validate
```
- The `terraform validate` command returned a `Success!` message, confirming the code is well-formed and correct. `terraform plan` and `apply` were not run, as they require active cloud credentials.

### Part 2: Helm Chart Configuration

The prerequisite Helm chart in `solution_helm/` was reviewed and modified to consume a configuration value.

### What Was Done
*   **Reviewed `values.yaml`:** Confirmed the existence of a `greeting` key to hold the default configuration message. The default message was updated to clearly show that the file had been reviewed.
*   **Reviewed `templates/deployment.yaml`:** Confirmed that the Deployment manifest already contained a correctly configured `env` block. This block sets the `GREETING_MESSAGE` environment variable in the container, using the `greeting` value from `values.yaml` as its source. Comments were updated to improve clarity.

### Local Verification

The Helm chart was validated locally using the following commands:
```powershell
# Navigate to the helm chart directory
cd Junior/INT-J-1/solution_helm/

# Lint the chart for best practices and syntax errors
helm lint .

# Perform a dry run to render the final Kubernetes manifest
helm template simple-config-app .
```

- The helm lint command passed successfully. The output of helm template was inspected and confirmed to contain the GREETING_MESSAGE environment variable with the correct default value from values.yaml.

### Part 3: GitHub Actions CI/CD Workflow

A CI/CD pipeline was created at `.github/workflows/int-j-1-pipeline.yml` to automate the validation and testing process.

### Workflow Features

*   **Smart Triggers:** Runs automatically on pushes or pull requests to `main`, but only if files under `Junior/INT-J-1/` are changed. This avoids unnecessary runs in a monorepo setup.
*   **Manual Trigger:** `workflow_dispatch` allows running the workflow manually from GitHub Actions.  
*   **Terraform Validation:** Initializes and validates the Terraform code to ensure correctness.
*  **Helm Testing:** Lints the Helm chart and renders manifests with `helm template`. The `--set` flag overrides the greeting to demonstrate configurability.  
*   **Graceful Failure:** The `terraform apply` step is expected to fail (no cloud credentials), but `continue-on-error: true` ensures the rest of the pipeline runs successfully, including Helm tests.

### Verification

The successful execution of this workflow in the GitHub Actions tab is the final verification for this task. The process is:

1.  Push all committed changes to the `main` branch of the GitHub repository.
2.  Navigate to the **"Actions"** tab on the repository's GitHub page.
3.  Observe the workflow run named **"INT-J-1: Terraform and Helm CI Pipeline"**.

- A successful run will show green checks for all steps except **"Attempt Terraform Apply"**, which will show a warning (allowed to fail).  
- This confirms the CI/CD pipeline is set up correctly.

