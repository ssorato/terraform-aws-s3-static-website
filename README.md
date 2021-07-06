# Terraform AWS S3 static website

A sample static web site stored in a s3 bucket.

Please, fill the correct `domain_name` inside the [terraform.tfvars](terraform.tfvars) file 

# Tip

Save the terraform state in a s3 bucket by creating a `backend.tf`

```
terraform {
  backend "s3" {
    bucket = "the-bucket-name"
    key    = "terraform-s3-static-website"
    region = "us-east-1"
  }
}
```
