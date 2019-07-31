locals {
  vpc_cidr = "172.16.16.0/20"
}

data "aws_availability_zones" "azs" {}

resource "null_resource" "let_subnet" {
  count = length(data.aws_availability_zones.azs.names)

  triggers = {
    public_subnets   = cidrsubnet(local.vpc_cidr, 7, 0+count.index)
  }
}

resource "aws_vpc" "this" {
  cidr_block = "172.16.16.0/20"

  tags = {
    Name = "example-simple-elb"
  }
}

resource "aws_subnet" "this_public" {
  count = length(data.aws_availability_zones.azs.names)

  cidr_block = element(null_resource.let_subnet.*.triggers.public_subnets, count.index)
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "this_public" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "example-simple-elb-public"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "example-simple-elb-public"
  }
}

resource "aws_route_table_association" "this_public" {
  count = length(aws_subnet.this_public.*.id)
  route_table_id = aws_route_table.this_public.id
  subnet_id = aws_subnet.this_public.*.id[count.index]
}

resource "aws_route" "this_ig" {
  route_table_id = aws_route_table.this_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
}