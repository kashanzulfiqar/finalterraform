terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # --- REMOTE STATE BACKEND ---
  backend "s3" {
    bucket = "kashan-stagingtfstate-storage-2026"
    key    = "staging/terraform.tfstate"
    region = "us-east-1"
  }
} 

provider "aws" {
  region = "us-east-1"
}

module "staging_infra" {
  source = "../../modules/app_stack"
  
  environment              = "staging"
  instance_type            = "t3.micro"
  ami_id                   = "ami-0b6d9d3d33ba97d99"
  key_name                 = "keyforec2"
  backend_domain_name      = "stage-api.daftarpro.com"
  preallocated_eip_address = "YOUR_STAGING_ELASTIC_IP_HERE" # Replace with your actual static IP string
}

output "staging_ec2_ip" {
  value = module.staging_infra.ec2_public_ip
}

output "staging_cloudfront_id" {
  value = module.staging_infra.cloudfront_distribution_id
}

output "staging_site_url" {
  value = "https://${module.staging_infra.cloudfront_domain_name}"
}
