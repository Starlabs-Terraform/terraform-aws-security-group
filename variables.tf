variable "info" {
  description = "[Required] Project Info"
  type = object({
    project = optional(string, "pj")
    stage = optional(string, "stg")
    tag_id = tuple([string, string])
    region = optional(string, "ap-northeast-2")
    tags = optional(map(string), {})
    tag_name_upper = optional(bool, false)
  })
}
variable "infra" {
  description = "[Required] Infra ID List"
  type = map(map(string))
}
variable "security_group_rule" {
  description = "[Optional] Security Group Rule - List"
  type = list(object({
    security_group_name = string
    description = optional(string, null)
    type = optional(string, "ingress")
    from_port = optional(number, 0)
    to_port = optional(number, 0)
    protocol = optional(string, "tcp")
    cidr_blocks_subnet_names = optional(list(string), null)
    cidr_blocks_ips = optional(list(string), null)
    cidr_blocks_vpc = optional(bool, false)
    cidr_blocks_vpc_association_name = optional(string, null)
    source_security_group_name = optional(string, null)
  }))
  default = []
}