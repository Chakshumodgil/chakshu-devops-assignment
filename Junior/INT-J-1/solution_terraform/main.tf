# /Junior\INT-J-1\solution_terraform\main.tf

# Define the required providers for this configuration
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# Configure the Google provider with project and region details
# The project ID is a placeholder, as we are not connecting to a real GCP account.
provider "google" {
  project = "app-config-assignment-project"
  region  = "europe-west3"
}


# Create a random suffix to ensure the bucket name is unique
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# This resource defines the Google Cloud Storage (GCS) bucket.
# It will be used to store our configuration file.
resource "google_storage_bucket" "config_bucket" {
  name     = "app-config-bucket-${random_id.bucket_suffix.hex}"
  location = "europe-west3"

  # Use uniform access control for simplified permissions
  uniform_bucket_level_access = true

  # Set to true for non-production environments to simplify cleanup
  force_destroy = true
}

# This resource defines the file (an "object") to be uploaded to our GCS bucket.
resource "google_storage_bucket_object" "settings_file" {
  # This is the full path and name the file will have inside the bucket.
  name    = "config/settings.txt"
  
  # This links the file to the bucket we defined above.
  bucket  = google_storage_bucket.config_bucket.name
  
  # 'source' tells Terraform to upload a local file.
  # '${path.module}' is a best practice that ensures Terraform always looks for the file in the same directory as the main.tf file.
  source  = "${path.module}/config/settings.txt"
}