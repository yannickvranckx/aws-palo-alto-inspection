# infra file
# -----------

# VPC and Flow logs to Cloudwatch
# -------------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_main
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  tags = {
    Name = var.vpc_name
  }
}
resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_cidr_secondary
}

resource "aws_flow_log" "vpc_flow_log" {
  log_destination      = aws_cloudwatch_log_group.firewall_vpc.arn
  log_destination_type = "cloud-watch-logs"
  iam_role_arn         = aws_iam_role.vpc_flow_log_role.arn
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main.id
}

resource "aws_cloudwatch_log_group" "firewall_vpc" {
  name = var.aws_cloudwatch_log_group
  retention_in_days = 180
}

# Supporting resources
# -------------------------------

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "vpc_flow_log_role" {
  name               = "RoleVPCFlowLogPushToCloudWatch"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "log_allow" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "example" {
  name   = "PolicyVPCFlowLogPushToCloudwatch"
  role   = aws_iam_role.vpc_flow_log_role.id
  policy = data.aws_iam_policy_document.log_allow.json
}

# Subnets and routing
# -------------------

# AZ - A
# -------
resource "aws_subnet" "tgw_subnet_a" {
  vpc_id            = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block        = var.tgw_subnets.0
  availability_zone = var.az.0

  tags = {
    Name = var.tgw_subnets_tags.0
  }
}
resource "aws_subnet" "gwlb_endpoint_subnet_a" {
  vpc_id            = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block        = var.gwlb_subnets_endpoint.0
  availability_zone = var.az.0

  tags = {
    Name = var.gwlb_subnets_endpoint_tags.0
  }
}
resource "aws_subnet" "gwlb_lb_subnet_a" {
  vpc_id            = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block        = var.gwlb_subnets_lb.0
  availability_zone = var.az.0

  tags = {
    Name = var.gwlb_subnets_lb_tags.0
  }
}
resource "aws_subnet" "pa_subnet_private_a" {
  vpc_id            = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block        = var.pa_subnets_private.0
  availability_zone = var.az.0

  tags = {
    Name = var.pa_subnets_private_tags.0
  }
}
resource "aws_subnet" "pa_subnet_public_a" {
  vpc_id            = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block        = var.pa_subnets_public.0
  availability_zone = var.az.0

  tags = {
    Name = var.pa_subnets_public_tags.0
  }
}
resource "aws_subnet" "pa_subnet_mgmt_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.pa_subnets_mgmt.0
  availability_zone = var.az.0

  tags = {
    Name = var.pa_subnets_mgmt_tags.0
  }
}

# AZ - B
# ------
resource "aws_subnet" "tgw_subnet_b" {
  vpc_id            = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block        = var.tgw_subnets.1
  availability_zone = var.az.1

  tags = {
    Name = var.tgw_subnets_tags.1
  }
}
resource "aws_subnet" "gwlb_endpoint_subnet_b" {
  vpc_id            = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block        = var.gwlb_subnets_endpoint.1
  availability_zone = var.az.1

  tags = {
    Name = var.gwlb_subnets_endpoint_tags.1
  }
}
resource "aws_subnet" "gwlb_lb_subnet_b" {
  vpc_id            = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block        = var.gwlb_subnets_lb.1
  availability_zone = var.az.1

  tags = {
    Name = var.gwlb_subnets_lb_tags.1
  }
}
resource "aws_subnet" "pa_subnet_private_b" {
  vpc_id            = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block        = var.pa_subnets_private.1
  availability_zone = var.az.1

  tags = {
    Name = var.pa_subnets_private_tags.1
  }
}
resource "aws_subnet" "pa_subnet_public_b" {
  vpc_id            = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block        = var.pa_subnets_public.1
  availability_zone = var.az.1

  tags = {
    Name = var.pa_subnets_public_tags.1
  }
}
resource "aws_subnet" "pa_subnet_mgmt_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.pa_subnets_mgmt.1
  availability_zone = var.az.1

  tags = {
    Name = var.pa_subnets_mgmt_tags.1
  }
}

# ROUTING AZ-A
# ------------
resource "aws_route_table" "route_tgw_subnet_a" {
  vpc_id = aws_vpc.main.id


  tags = {
    Name = var.route_tgw_subnet_a_tag
  }
}
resource "aws_route_table_association" "route_tgw_subnet_a" {
  subnet_id      = aws_subnet.tgw_subnet_a.id
  route_table_id = aws_route_table.route_tgw_subnet_a.id
}

resource "aws_route_table" "route_tgw_subnet_b" {
  vpc_id = aws_vpc.main.id


  tags = {
    Name = var.route_tgw_subnet_b_tag
  }
}
resource "aws_route_table_association" "route_tgw_subnet_b" {
  subnet_id      = aws_subnet.tgw_subnet_b.id
  route_table_id = aws_route_table.route_tgw_subnet_b.id
}

resource "aws_route_table" "route_gwlb_endpoint_subnet_a" {
  vpc_id = aws_vpc.main.id


  tags = {
    Name = var.route_gwlb_endpoint_subnet_a_tag
  }
}
resource "aws_route_table_association" "route_gwlb_endpoint_subnet_a" {
  subnet_id      = aws_subnet.gwlb_endpoint_subnet_a.id
  route_table_id = aws_route_table.route_gwlb_endpoint_subnet_a.id
}

resource "aws_route_table" "route_gwlb_endpoint_subnet_b" {
  vpc_id = aws_vpc.main.id


  tags = {
    Name = var.route_gwlb_endpoint_subnet_b_tag
  }
}
resource "aws_route_table_association" "route_gwlb_endpoint_subnet_b" {
  subnet_id      = aws_subnet.gwlb_endpoint_subnet_b.id
  route_table_id = aws_route_table.route_gwlb_endpoint_subnet_b.id
}

resource "aws_route_table" "route_gwlb_lb_subnet_a" {
  vpc_id = aws_vpc.main.id


  tags = {
    Name = var.route_gwlb_lb_subnet_a_tag
  }
}
resource "aws_route_table_association" "route_gwlb_lb_subnet_a" {
  subnet_id      = aws_subnet.gwlb_lb_subnet_a.id
  route_table_id = aws_route_table.route_gwlb_lb_subnet_a.id
}

resource "aws_route_table" "route_gwlb_lb_subnet_b" {
  vpc_id = aws_vpc.main.id


  tags = {
    Name = var.route_gwlb_lb_subnet_b_tag
  }
}
resource "aws_route_table_association" "route_gwlb_lb_subnet_b" {
  subnet_id      = aws_subnet.gwlb_lb_subnet_b.id
  route_table_id = aws_route_table.route_gwlb_lb_subnet_b.id
}

resource "aws_route_table" "route_pa_subnet_private_a" {
  vpc_id = aws_vpc.main.id


  tags = {
    Name = var.route_pa_subnet_private_a_tag
  }
}
resource "aws_route_table_association" "route_pa_subnet_private_a" {
  subnet_id      = aws_subnet.pa_subnet_private_a.id
  route_table_id = aws_route_table.route_pa_subnet_private_a.id
}

resource "aws_route_table" "route_pa_subnet_private_b" {
  vpc_id = aws_vpc.main.id


  tags = {
    Name = var.route_pa_subnet_private_b_tag
  }
}
resource "aws_route_table_association" "route_pa_subnet_private_b" {
  subnet_id      = aws_subnet.pa_subnet_private_b.id
  route_table_id = aws_route_table.route_pa_subnet_private_b.id
}

resource "aws_route_table" "route_pa_subnet_public_a" {
  vpc_id = aws_vpc.main.id


  tags = {
    Name = var.route_pa_subnet_public_a_tag
  }
}
resource "aws_route_table_association" "route_pa_subnet_public_a" {
  subnet_id      = aws_subnet.pa_subnet_public_a.id
  route_table_id = aws_route_table.route_pa_subnet_public_a.id
}

resource "aws_route_table" "route_pa_subnet_public_b" {
  vpc_id = aws_vpc.main.id


  tags = {
    Name = var.route_pa_subnet_public_b_tag
  }
}
resource "aws_route_table_association" "route_pa_subnet_public_b" {
  subnet_id      = aws_subnet.pa_subnet_public_b.id
  route_table_id = aws_route_table.route_pa_subnet_public_b.id
}

resource "aws_route_table" "route_pa_subnet_mgmt" {
  vpc_id = aws_vpc.main.id


  tags = {
    Name = var.route_pa_subnet_mgmt_tag
  }
}
resource "aws_route_table_association" "route_pa_subnet_mgmt_a" {
  subnet_id      = aws_subnet.pa_subnet_mgmt_a.id
  route_table_id = aws_route_table.route_pa_subnet_mgmt.id
}
resource "aws_route_table_association" "route_pa_subnet_mgmt_b" {
  subnet_id      = aws_subnet.pa_subnet_mgmt_b.id
  route_table_id = aws_route_table.route_pa_subnet_mgmt.id
}


# LOCAL ROUTING
# --------------

#Routing required to do default routing to VPC endpoints
resource "aws_route" "add_route_to_tgw_a" {
  route_table_id         = aws_route_table.route_gwlb_endpoint_subnet_a.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = local.tgw_id
  depends_on             = [aws_route_table.route_gwlb_endpoint_subnet_a]
}

resource "aws_route" "add_route_to_tgw_b" {
  route_table_id         = aws_route_table.route_gwlb_endpoint_subnet_b.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = local.tgw_id
  depends_on             = [aws_route_table.route_gwlb_endpoint_subnet_b]
}

#Routing required to route management subnet to jumphost
resource "aws_route" "add_route_jumphost_mgmt" {
  route_table_id         = aws_route_table.route_pa_subnet_mgmt.id
  destination_cidr_block = "10.40.74.108/32"
  transit_gateway_id     = local.tgw_id
  depends_on             = [aws_route_table.route_pa_subnet_mgmt]
}

# LOAD BALANCER
# -------------

resource "aws_lb" "gwlb" {
  name               = var.gwlb_name
  load_balancer_type = "gateway"
  enable_cross_zone_load_balancing = true

  subnet_mapping {
    subnet_id = aws_subnet.gwlb_lb_subnet_a.id
  }

  subnet_mapping {
    subnet_id = aws_subnet.gwlb_lb_subnet_b.id
  }

}

resource "aws_lb_target_group" "pa_instances" {
  name        = var.gwlb_target_group
  port        = 6081
  protocol    = "GENEVE"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"


  health_check {
    port     = 80
    protocol = "HTTP"

  }
}

/*
resource "aws_lb_target_group_attachment" "pa_instances" {
  target_group_arn = aws_lb_target_group.pa_instances.arn
  target_id        = aws_instance.pa.id
  port             = 80
}
*/

# VPC ENDPOINTS and SERVICE
# --------------------------

resource "aws_vpc_endpoint_service" "firewall_pa" {
  acceptance_required        = false
  gateway_load_balancer_arns = [aws_lb.gwlb.arn]
}

resource "aws_vpc_endpoint" "firewall_pa_a" {
  service_name      = aws_vpc_endpoint_service.firewall_pa.service_name
  subnet_ids        = [aws_subnet.gwlb_endpoint_subnet_a.id]
  vpc_endpoint_type = aws_vpc_endpoint_service.firewall_pa.service_type
  vpc_id            = aws_vpc.main.id
}

resource "aws_vpc_endpoint" "firewall_pa_b" {
  service_name      = aws_vpc_endpoint_service.firewall_pa.service_name
  subnet_ids        = [aws_subnet.gwlb_endpoint_subnet_b.id]
  vpc_endpoint_type = aws_vpc_endpoint_service.firewall_pa.service_type
  vpc_id            = aws_vpc.main.id
}


resource "aws_route" "add_route_to_vpce_a" {
  route_table_id         = aws_route_table.route_tgw_subnet_a.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = aws_vpc_endpoint.firewall_pa_a.id
  depends_on             = [aws_vpc_endpoint.firewall_pa_a]
}

resource "aws_route" "add_route_to_vpce_b" {
  route_table_id         = aws_route_table.route_tgw_subnet_b.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = aws_vpc_endpoint.firewall_pa_b.id
  depends_on             = [aws_vpc_endpoint.firewall_pa_a]
}


# PUBLIC EGRESS
# --------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_route" "pa_egress_a" {
  route_table_id         = aws_route_table.route_pa_subnet_public_a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_route_table.route_pa_subnet_public_a, aws_internet_gateway.igw]
}

resource "aws_route" "pa_egress_b" {
  route_table_id         = aws_route_table.route_pa_subnet_public_b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_route_table.route_pa_subnet_public_b, aws_internet_gateway.igw]
}

resource "aws_route" "pa_mgmt_egress_a" {
  route_table_id         = aws_route_table.route_pa_subnet_mgmt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_route_table.route_pa_subnet_mgmt]
}
