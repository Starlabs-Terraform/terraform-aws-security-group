resource "aws_security_group_rule" "create" {
  for_each          = {for k, v in var.security_group_rule : k => v}
  security_group_id = var.infra.security_group_id[each.value.security_group_name]
  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  description       = each.value.description
  cidr_blocks       =  each.value.cidr_blocks_subnet_names != null ? [ for ka, va in each.value.cidr_blocks_subnet_names : var.infra.subnet_cidr[va] ] : each.value.cidr_blocks_ips != null ? each.value.cidr_blocks_ips : each.value.cidr_blocks_vpc ? [ var.infra.vpc.cidr_block ] : each.value.cidr_blocks_vpc_association_name != null ? [ var.infra.cidr_association_cidr[each.value.cidr_blocks_vpc_association_name] ] : null
  source_security_group_id = each.value.source_security_group_name != null ? var.infra.security_group_id[each.value.source_security_group_name] : null
}