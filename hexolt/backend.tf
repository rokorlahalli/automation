terraform {
  backend "s3" {
    bucket         = "hex-tf-state"
    key            = "terraform-tfstate" // The path to your state file in the bucket
    region         = "us-east-1"         // Your desired AWS region
    #dynamodb_table = "terraform_locks"    // Optional: DynamoDB table name for state locking
  }
}

