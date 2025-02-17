terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0" # Or specify your desired version
    }
  }
}

provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name # Use the variable for the bucket name

  # Optional: Add other configurations as needed
  # acl = "private"
  # force_destroy = true # Be careful with this!
  # versioning {
  # enabled = true
  # }

  tags = {
    Name = "My Terraform Bucket"
    Environment = "dev"
  }
}

# Optional: Block Public Access to Bucket
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.my_bucket.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.id
}