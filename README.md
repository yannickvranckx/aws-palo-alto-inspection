# Repository to deploy the network inspection module for the NGFW solution Palo Alto on AWS
- Network AWS Account: 862334189785

# Terraform Resources
- VPC
- Subnets
- Routing Tables / Routes
- Flow Logs
- Transit Gateway Attachments
- Gateways

# Networking resources

- VPC CIDRs
------------
|     CIDR         | IP Range   | Subnet Mask  |       Usage         |
|------------------|------------|--------------|---------------------|
|  10.198.9.0      |     /      |    /24       | VPC CIDR MANAGEMENT |
|  100.64.0.0      |     /      |    /16       | VPC CIDR FIREWALL   |

- Subnetting
-------------

|     Network       | IP Range    | Subnet Mask |                   Usage                 |
|-------------------|-------------|-------------|-----------------------------------------|
|  100.64.0.0/28    | .1 - .14    |     /28     | Private Subnet TGW - A                  |
|  100.64.0.16/28   | .17 - .30   |     /28     | Private Subnet TGW - B                  |
|  100.64.0.48/28   | .49 - .62   |     /28     | Private Subnet GWLB - Endpoints - A     |
|  100.64.0.64/28   | .65 - .78   |     /28     | Private Subnet GWLB - Endpoints - B     |
|  100.64.0.192/28  | .193 - .206 |     /28     | Private Subnet GWLB - Load Balancer - A |
|  100.64.0.208/28  | .209 - .222 |     /28     | Private Subnet GWLB - Load Balancer - B |
|  100.64.0.96/28   | .97 - .110  |     /28     | Private Subnet PA-Instance - A          |
|  100.64.0.112/28  | .113 - .126 |     /28     | Private Subnet PA-Instance - B          |
|  10.198.9.32/28   | .33 - .46   |     /28     | Public Subnet PA - Egress - A           |
|  10.198.9.48/28   | .49 - .62   |     /28     | Public Subnet PA - Egress - B           |
|  10.198.9.0/28    | .1 - .14    |     /28     | Public Subnet PA - MGMT - A             |
|  10.198.9.16/28   | .17 - .30   |     /28     | Public Subnet PA - MGMT - B             |

#                Terraform State
---------------------------------------------
State for this project is handled in 2 different ways:

- Stored on Gitlab
- Stored in the account on S3