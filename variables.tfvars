aws_region                       = "eu-west-3"
vpc_cidr_main                    = "10.198.9.0/24"
vpc_cidr_secondary               = "100.64.0.0/16"
vpc_name                         = "vpc-euw3-firewall"
tgw_subnets                      = ["100.64.0.0/28", "100.64.0.16/28"]
tgw_subnets_tags                 = ["subnet-euw3-private-tgw-a", "subnet-euw3-private-tgw-b"]
gwlb_subnets_endpoint            = ["100.64.0.48/28", "100.64.0.64/28"]
gwlb_subnets_endpoint_tags       = ["subnet-euw3-private-gwlb-endpoint-a", "subnet-euw3-private-gwlb-endpoint-b"]
gwlb_subnets_lb                  = ["100.64.0.192/28", "100.64.0.208/28"]
gwlb_subnets_lb_tags             = ["subnet-euw3-private-gwlb-a", "subnet-euw3-private-gwlb-b"]
pa_subnets_private               = ["100.64.0.96/28", "100.64.0.112/28"]
pa_subnets_private_tags          = ["subnet-euw3-private-pa-a", "subnet-euw3-private-pa-b"]
pa_subnets_public                = ["10.198.9.32/28", "10.198.9.48/28"]
pa_subnets_public_tags           = ["subnet-euw3-public-pa-a", "subnet-euw3-public-pa-b"]
pa_subnets_mgmt                  = ["10.198.9.0/28", "10.198.9.16/28"]
pa_subnets_mgmt_tags             = ["subnet-euw3-mgmt-pa-a", "subnet-euw3-mgmt-pa-b"]
route_tgw_subnet_a_tag           = "rt-private-tgw-a"
route_tgw_subnet_b_tag           = "rt-private-tgw-b"
route_gwlb_endpoint_subnet_a_tag = "rt-private-gwlb-endpoint-a"
route_gwlb_endpoint_subnet_b_tag = "rt-private-gwlb-endpoint-b"
route_gwlb_lb_subnet_a_tag       = "rt-private-gwlb-lb-a"
route_gwlb_lb_subnet_b_tag       = "rt-private-gwlb-lb-b"
route_pa_subnet_private_a_tag    = "rt-private-pa-a"
route_pa_subnet_private_b_tag    = "rt-private-pa-b"
route_pa_subnet_public_a_tag     = "rt-public-pa-a"
route_pa_subnet_public_b_tag     = "rt-public-pa-b"
route_pa_subnet_mgmt_tag         = "rt-management-a-b"
gwlb_name                        = "lb-euw3-gwlb-palo-alto"
gwlb_target_group                = "gwlb-target-group-pa-instances"
aws_cloudwatch_log_group         = "log-euw3-vpc-firewall-all-traffic"
igw_name                         = "euw3-internet-gateway-egress"
tgw_rt_inspection_name           = "rt_firewall_inspection (PALO ALTO)"
tgw_rt_post_inspection_name      = "rt_firewall_post_inspection (PALO ALTO)"
tgw_attach_post_inspection_name  = "tgw-attachment-euw3-firewall-vpc"
on_prem_ranges                   = ["10.81.0.0/16", "10.82.0.0/16", "10.80.0.0/16", "10.40.0.0/16"]
peering_ranges                   = ["10.190.0.0/16", "10.191.0.0/16"]