variable "region" {}

provider "aws" {
  region = var.region
}

resource "aws_security_group" "this" {
  name = "simple-load-balancer"
  vpc_id = aws_vpc.this.id
  description = "Example create a Simple Load Balancer"

  ingress {
    from_port = 0
    protocol = -1
    to_port = 0

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = -1
    to_port = 0

    cidr_blocks = ["0.0.0.0/0"]
  }
}

##
#  Create alb here
##

module "simple-elb" {
  source = "../../"

  name            = "simple-load-balancer"
  tier            = "production"
  organization    = "example"
  subnets         = aws_subnet.this_public.*.id
  security_groups = [aws_security_group.this.id]
}
