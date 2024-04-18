#VPC
resource "aws_vpc" "my_vpc" {
  cidr_block       = "${var.vpc_cidr}"   # IPv4 CIDR block for the VPC
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  assign_generated_ipv6_cidr_block = "${var.assign_generated_ipv6_cidr_block}"      # Enable IPv6 support for the VPC

  tags = {
    Name = var.vpc_name
  }
}

#IGW
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id          # Attach the Internet Gateway to the VPC
}

#EIGW
resource "aws_egress_only_internet_gateway" "my_eigw" {
  #count = var.assign_generated_ipv6_cidr_block ? 1 : 0  # Create EIGW only if IPv6 is enabled
  vpc_id = aws_vpc.my_vpc.id
}

#NAT GATEWAY EIP
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id
}

#Load Balancer Subnets

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id      # Reference to the VPC
  cidr_block = var.public_subnet_1          # IPv4 CIDR block for the subnet
  availability_zone = "${var.region}a"     # Choose your desired availability zone

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.pub_subnet_name}-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id      # Reference to the VPC
  cidr_block = var.public_subnet_2          # IPv4 CIDR block for the subnet
  availability_zone = "${var.region}b"     # Choose your desired availability zone

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.pub_subnet_name}-2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id     = aws_vpc.my_vpc.id      # Reference to the VPC
  cidr_block = var.public_subnet_3          # IPv4 CIDR block for the subnet
  availability_zone = "${var.region}c"     # Choose your desired availability zone

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.pub_subnet_name}-3"
  }
}


#Gateway Subnets

resource "aws_subnet" "gateway_subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id      # Reference to the VPC
  cidr_block = var.gateway_subnet_1          # IPv4 CIDR block for the subnet
  availability_zone = "${var.region}a"     # Choose your desired availability zone

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.gateway_subnet_name}-1"
  }
}


resource "aws_subnet" "gateway_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id      # Reference to the VPC
  cidr_block = var.gateway_subnet_2          # IPv4 CIDR block for the subnet
  availability_zone = "${var.region}b"     # Choose your desired availability zone

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.gateway_subnet_name}-2"
  }
}

#Public Route Table

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id          # Reference to the VPC

  route {
    cidr_block = "0.0.0.0/0"          # Route for IPv4 traffic
    gateway_id = aws_internet_gateway.my_igw.id
  }
 
  #route {
  #  cidr_block = "::/0" 
  #  gateway_id = aws_internet_gateway.my_igw.id
  #}

}

#Public Route Table Association

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id      # Associate the route table with the subnet
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id      # Associate the route table with the subnet
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_3_association" {
  subnet_id      = aws_subnet.public_subnet_3.id      # Associate the route table with the subnet
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "gateway_subnet_1_association" {
  subnet_id      = aws_subnet.gateway_subnet_1.id      # Associate the route table with the subnet
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "gateway_subnet_2_association" {
  subnet_id      = aws_subnet.gateway_subnet_2.id      # Associate the route table with the subnet
  route_table_id = aws_route_table.public_route_table.id
}

#Application Subnets

resource "aws_subnet" "app_subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id      # Reference to the VPC
  cidr_block = var.app_subnet_1          # IPv4 CIDR block for the subnet
  availability_zone = "${var.region}a"     # Choose your desired availability zone

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.app_subnet_name}-1"
  }
}

resource "aws_subnet" "app_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id      # Reference to the VPC
  cidr_block = var.app_subnet_2          # IPv4 CIDR block for the subnet
  availability_zone = "${var.region}b"     # Choose your desired availability zone

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.app_subnet_name}-2"
  }
}

resource "aws_subnet" "app_subnet_3" {
  vpc_id     = aws_vpc.my_vpc.id      # Reference to the VPC
  cidr_block = var.app_subnet_3          # IPv4 CIDR block for the subnet
  availability_zone = "${var.region}c"     # Choose your desired availability zone

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.app_subnet_name}-2"
  }
}

#Database Subnets

resource "aws_subnet" "db_subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id      # Reference to the VPC
  cidr_block = var.db_subnet_1          # IPv4 CIDR block for the subnet
  availability_zone = "${var.region}a"     # Choose your desired availability zone

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.db_subnet_name}-1"
  }
}

resource "aws_subnet" "db_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id      # Reference to the VPC
  cidr_block = var.db_subnet_2          # IPv4 CIDR block for the subnet
  availability_zone = "${var.region}b"     # Choose your desired availability zone

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.db_subnet_name}-2"
  }
}

resource "aws_subnet" "db_subnet_3" {
  vpc_id     = aws_vpc.my_vpc.id      # Reference to the VPC
  cidr_block = var.db_subnet_3          # IPv4 CIDR block for the subnet
  availability_zone = "${var.region}c"     # Choose your desired availability zone

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.db_subnet_name}-3"
  }
}

#Monitoring Subnets

resource "aws_subnet" "monitoring_subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id      # Reference to the VPC
  cidr_block = var.monitoring_subnet_1          # IPv4 CIDR block for the subnet
  availability_zone = "${var.region}a"     # Choose your desired availability zone

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.monitoring_subnet_name}-1"
  }
}

resource "aws_subnet" "monitoring_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id      # Reference to the VPC
  cidr_block = var.monitoring_subnet_2          # IPv4 CIDR block for the subnet
  availability_zone = "${var.region}b"     # Choose your desired availability zone

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.monitoring_subnet_name}-2"
  }
}

#Private Route Table

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id          # Reference to the VPC

  route {
    cidr_block = "0.0.0.0/0"          # Route for IPv4 traffic
    gateway_id = aws_nat_gateway.my_nat_gateway.id
  }

  #route {
  #  cidr_block = "::/0"    # Route for IPv6 traffic
  #  gateway_id = aws_egress_only_internet_gateway.my_eigw.id
  #}

}

#Private Route Table Association

resource "aws_route_table_association" "app_subnet_1_association" {
  subnet_id      = aws_subnet.app_subnet_1.id      # Associate the route table with the subnet
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "app_subnet_2_association" {
  subnet_id      = aws_subnet.app_subnet_2.id      # Associate the route table with the subnet
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "app_subnet_3_association" {
  subnet_id      = aws_subnet.app_subnet_3.id      # Associate the route table with the subnet
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "db_subnet_1_association" {
  subnet_id      = aws_subnet.db_subnet_1.id      # Associate the route table with the subnet
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "db_subnet_2_association" {
  subnet_id      = aws_subnet.db_subnet_2.id      # Associate the route table with the subnet
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "db_subnet_3_association" {
  subnet_id      = aws_subnet.db_subnet_3.id      # Associate the route table with the subnet
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "monitoring_subnet_1_association" {
  subnet_id      = aws_subnet.monitoring_subnet_1.id      # Associate the route table with the subnet
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "monitoring_subnet_2_association" {
  subnet_id      = aws_subnet.monitoring_subnet_2.id      # Associate the route table with the subnet
  route_table_id = aws_route_table.private_route_table.id
}
