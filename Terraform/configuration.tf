terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.47"
    }
  }
}
variable "region"{
 description = "Region for aws"  
}
provider "aws" {
  profile = "default"
  region  = var.region
}