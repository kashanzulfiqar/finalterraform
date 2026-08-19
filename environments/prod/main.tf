terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # --- REMOTE STATE BACKEND ---
  backend "s3" {
    bucket = "kashan-prodtfstate-storage-2026"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
} 

provider "aws" {
  region = "us-east-1"
}

module "prod_infra" {
  source = "../../modules/app_stack"
  
  environment              = "prod"
  instance_type            = "t3.micro"
  ami_id                   = "ami-0b6d9d3d33ba97d99"
  key_name                 = "keyforec2"
  backend_domain_name      = "api.daftarpro.com"
  preallocated_eip_address = "YOUR_PROD_ELASTIC_IP_HERE" # Replace with your actual static IP string
}

output "prod_ec2_ip" {
  value = module.prod_infra.ec2_public_ip
}

output "prod_cloudfront_id" {
  value = module.prod_infra.cloudfront_distribution_id
}

output "prod_site_url" {
  value = "https://${module.prod_infra.cloudfront_domain_name}"
}
