# Variable file
# --------------

# Main vars
# ---------
variable "aws_region" {
  description = "Region to set deployment in"
  type        = string
}
variable "az" {
  description = "Availability Zones"
  default     = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
}

# Infra Variables
variable "vpc_cidr_main" {
  description = "CIDR VPC"
  type        = string
}
variable "vpc_cidr_secondary" {
  description = "CIDR VPC"
  type        = string
}
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}
variable "aws_cloudwatch_log_group" {
  description = "Name of the CloudWatch group"
  type        = string
}
variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

# Subnets
# -------
variable "tgw_subnets" {
  description = "Transit Gateway Subnets - ordered by AZ"
  type        = list(string)
}
variable "tgw_subnets_tags" {
  description = "Transit Gateway Subnets - ordered by AZ - TAGS"
  type        = list(string)
}
variable "gwlb_subnets_endpoint" {
  description = "Gateway Load Balancers Subnets - ordered by AZ"
  type        = list(string)
}
variable "gwlb_subnets_endpoint_tags" {
  description = "Transit Gateway Subnets - ordered by AZ - TAGS"
  type        = list(string)
}
variable "gwlb_subnets_lb" {
  description = "Gateway Load Balancers Subnets - ordered by AZ"
  type        = list(string)
}
variable "gwlb_subnets_lb_tags" {
  description = "Transit Gateway Subnets - ordered by AZ - TAGS"
  type        = list(string)
}
variable "pa_subnets_private" {
  description = "Palo Alto Appliance Subnets - ordered by AZ"
  type        = list(string)
}
variable "pa_subnets_private_tags" {
  description = "Palo Alto Appliance Subnets - ordered by AZ - TAGS"
  type        = list(string)
}
variable "pa_subnets_public" {
  description = "Palo Alto Appliance Subnets - ordered by AZ"
  type        = list(string)
}
variable "pa_subnets_public_tags" {
  description = "Palo Alto Appliance Subnets - ordered by AZ - TAGS"
  type        = list(string)
}
variable "pa_subnets_mgmt" {
  description = "Palo Alto Appliance Subnets - ordered by AZ"
  type        = list(string)
}
variable "pa_subnets_mgmt_tags" {
  description = "Palo Alto Appliance Subnets - ordered by AZ - TAGS"
  type        = list(string)
}

# Routing
# --------
variable "route_tgw_subnet_a_tag" {
  description = "Routing TGW Subnet - TAGS"
  type        = string
}
variable "route_tgw_subnet_b_tag" {
  description = "Routing TGW Subnet - TAGS"
  type        = string
}
variable "route_gwlb_endpoint_subnet_a_tag" {
  description = "Routing GWLB Endpoint Subnet - TAGS"
  type        = string
}
variable "route_gwlb_endpoint_subnet_b_tag" {
  description = "Routing GWLB Endpoint Subnet - TAGS"
  type        = string
}
variable "route_gwlb_lb_subnet_a_tag" {
  description = "Routing GWLB Subnet - TAGS"
  type        = string
}
variable "route_gwlb_lb_subnet_b_tag" {
  description = "Routing GWLB Subnet - TAGS"
  type        = string
}
variable "route_pa_subnet_private_a_tag" {
  description = "Routing PA Subnet private - TAGS"
  type        = string
}
variable "route_pa_subnet_private_b_tag" {
  description = "Routing PA Subnet private - TAGS"
  type        = string
}
variable "route_pa_subnet_public_a_tag" {
  description = "Routing PA Subnet public - TAGS"
  type        = string
}
variable "route_pa_subnet_public_b_tag" {
  description = "Routing PA Subnet public - TAGS"
  type        = string
}
variable "route_pa_subnet_mgmt_tag" {
  description = "Routing PA Subnet MGMT - TAGS"
  type        = string
}

# Load Balancer
# -------------
variable "gwlb_name" {
  description = "Name of the GWLB"
  type        = string
}
variable "gwlb_target_group" {
  description = "Name of the target group"
  type        = string
}

# Transit Gateway
# ---------------
variable "tgw_rt_inspection_name" {
  description = "Name of the route table"
  type        = string
}
variable "tgw_rt_post_inspection_name" {
  description = "Name of the route table"
  type        = string
}
variable "tgw_attach_post_inspection_name" {
  description = "Name of the attachment"
  type        = string
}
variable "on_prem_ranges" {
  description = "List of the on prem ranges"
  type        = list(string)
}
variable "peering_ranges" {
  description = "List of the on prem ranges"
  type        = list(string)
}