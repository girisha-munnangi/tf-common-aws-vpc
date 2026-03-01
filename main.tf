resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true
    tags = local.vpc_final_tags
    
}