locals {
  name_elb         = "${var.name}-${var.tier}"
}

resource "aws_lb" "this" {
  count = local.create_elb

  name = local.name_elb
  internal = var.is_internal
  load_balancer_type = var.type
  security_groups = var.security_groups

  subnets = var.subnets

  idle_timeout                     = var.idle_timeout
  enable_deletion_protection       = var.enable_deletion_protetcion
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_http2                     = var.enable_http2
  ip_address_type                  = var.ip_address_type

  #enable logs
  access_logs {
    enabled = var.access_log_bucket == "" ? false : true
    bucket = var.access_log_bucket
  }

  tags = merge(
  var.tags,
  {
    Name = local.name_elb
    Terraform = "true"
    Tier = var.tier
    Organization = var.organization
  }
  )

  timeouts {
    create = var.lb_timeouts["create"]
    update = var.lb_timeouts["update"]
    delete = var.lb_timeouts["delete"]
  }
}

