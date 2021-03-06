variable "lab_name" {
  type = string
  description = "Lab name"
}

variable "bucket_name" {
  type = string
  description = "The S3 bucket name"
}

variable "domain_name" {
  type = string
  description = "The domain name"
}

variable "common_tag" {
  type = map(string)
  description = "Common resource tags"
}
