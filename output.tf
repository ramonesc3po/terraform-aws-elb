##
# Load balancer
##
output "subnets" {
  value = aws_lb.this.*.subnets
}

output "vpc" {
  value = element(concatt(aws_lb.this.*.vpc_id, [""]), 0)
}

output "lb_dns_name" {
  value = element(concat(aws_lb.this.*.dns_name, [""]), 0)
}

output "lb_arn_suffix" {
  value = element(concat(aws_lb.this.*.arn_suffix, [""]), 0)
}

output "lb_arn" {
  value = element(concat(aws_lb.this.*.arn, [""]), 0)
}

output "lb_id" {
  value = element(concat(aws_lb.this.*.id, [""]), 0)
}

output "lb_zone_id" {
  value = element(concat(aws_lb.this.*.zone_id, [""]), 0)
}