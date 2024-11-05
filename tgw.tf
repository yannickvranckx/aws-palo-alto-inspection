# Adjustments to the live TGW
# ---------------------------
resource "aws_ec2_transit_gateway_route_table" "firewall_inspection" {
  transit_gateway_id = local.tgw_id

  tags = {
    Name = var.tgw_rt_inspection_name
  }
}

resource "aws_ec2_transit_gateway_route" "firewall_inspection" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.firewall_post_inspection.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.firewall_inspection.id
}

resource "aws_ec2_transit_gateway_route_table" "firewall_post_inspection" {
  transit_gateway_id = local.tgw_id

  tags = {
    Name = var.tgw_rt_post_inspection_name
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "firewall_post_inspection" {
  subnet_ids             = [aws_subnet.tgw_subnet_a.id, aws_subnet.tgw_subnet_b.id]
  transit_gateway_id     = local.tgw_id
  vpc_id                 = aws_vpc.main.id
  appliance_mode_support = "enable"

  tags = {
    Name = var.tgw_attach_post_inspection_name
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "firewall_post_inspection" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.firewall_post_inspection.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.firewall_post_inspection.id
}

# Adding the post-inspection routes - on-prem // other VPCs

resource "aws_ec2_transit_gateway_route" "on_prem_dc_1" {
  destination_cidr_block         = var.on_prem_ranges.0
  transit_gateway_attachment_id  = local.tgw_attachment_dx_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.firewall_post_inspection.id
}
resource "aws_ec2_transit_gateway_route" "on_prem_dc_2" {
  destination_cidr_block         = var.on_prem_ranges.1
  transit_gateway_attachment_id  = local.tgw_attachment_dx_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.firewall_post_inspection.id
}
resource "aws_ec2_transit_gateway_route" "on_prem_dc_3" {
  destination_cidr_block         = var.on_prem_ranges.2
  transit_gateway_attachment_id  = local.tgw_attachment_dx_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.firewall_post_inspection.id
}
resource "aws_ec2_transit_gateway_route" "on_prem_dc_4" {
  destination_cidr_block         = var.on_prem_ranges.3
  transit_gateway_attachment_id  = local.tgw_attachment_dx_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.firewall_post_inspection.id
}

resource "aws_ec2_transit_gateway_route" "peering_1" {
  destination_cidr_block         = var.peering_ranges.0
  transit_gateway_attachment_id  = local.peering_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.firewall_post_inspection.id
}

resource "aws_ec2_transit_gateway_route" "peering_2" {
  destination_cidr_block         = var.peering_ranges.1
  transit_gateway_attachment_id  = local.peering_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.firewall_post_inspection.id
}