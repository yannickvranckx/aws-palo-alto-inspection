#Generate Outputs

output "vpc_arn" {
  value = aws_vpc.main.arn
}
output "vpc_id" {
  value = aws_vpc.main.id
}
output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}
output "internet_gw" {
  value = aws_internet_gateway.igw.id
}
output "gateway_id" {
  value = aws_lb.gwlb.id
}