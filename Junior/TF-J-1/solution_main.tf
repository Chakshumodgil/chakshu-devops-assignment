# /Junior/TF-J-1/solution_main.tf

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
provider "google" {
  project = "my-tf-assignment-project"  
  region  = "europe-west3"
}

# Create a random suffix to ensure the bucket name is unique
resource "random_id" "bucket_id" {
  byte_length = 4
}

# Create the Google Cloud Storage bucket
resource "google_storage_bucket" "my_bucket" {
  name     = "my-unique-bucket-${random_id.bucket_id.hex}"
  location = "europe-west3"

  uniform_bucket_level_access = true  # Use uniform access control for simplified permissions
  force_destroy  = true   # Set to true for non-production environments to simplify cleanup
}

# NEW CODE FOR TASK TF-J-2 STARTS HERE

# Output the final, unique name of the created GCS bucket
output "bucket_name" {
  description = "The globally unique name of the GCS bucket."
  value       = google_storage_bucket.my_bucket.name
}