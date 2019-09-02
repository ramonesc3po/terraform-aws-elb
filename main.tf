locals {
  create_elb = var.create_lb == true ? 1 : 0
}
