##
# Load balancer
##
variable "create_lb" {
  description = "Set false if you not want create Load Balancer, default is true"
  default     = true
}

variable "name" {
  description = "(Optional) Set addtional name to Load Balancer"
  default     = ""
}

variable "tier" {
  description = "If you want be create load balancers with environments names"
}

variable "organization" {
  description = "Used organization set the name load balancer"
}

variable "is_internal" {
  description = "Should true if you want create internal load balancer, default is false"
  default     = false
}

variable "type" {
  description = "Type load balancer is application"
  default     = "application"
}

variable "subnets" {
  description = "Subnets for deploy laod balancer"
  default     = []
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed, set default is 60"
  default     = "60"
}

variable "enable_deletion_protetcion" {
  description = "Should set true if you want be disabled deletion via AWS API, this prevent terraform from deleting the load balancer, defaul is false"
  default     = false
}

variable "enable_cross_zone_load_balancing" {
  description = "If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature. Defaults to false"
  default     = false
}

variable "enable_http2" {
  description = "Enable http2, default is true"
  default     = true
}

variable "ip_address_type" {
  description = "Is type of IP address used by subnet for your load balancer, you can use ipv4 or dualstack, default is ipv4"
  default     = "ipv4"
}

variable "security_groups" {
  description = "Security group to attach load balancer"
  default     = []
}

variable "lb_timeouts" {
  description = "Set parameters for timeouts create, update and destroy"
  type        = map(string)

  default = {
    "create" = "60m"
    "update" = "60m"
    "delete" = "60m"
  }
}

variable "access_log_bucket" {
  type        = "string"
  description = "Necessary activate the access logs using the bucket name."
  default     = ""
}

variable "access_log_prefix" {
  type        = string
  description = "Prefix key"
  default     = "alb"
}

##
# General
##

variable "tags" {
  type    = "map"
  default = {}
}