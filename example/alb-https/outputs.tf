output "context" {
  value = module.ctx.context
}
output "pub_subnet_ids" {
  value = toset(data.aws_subnets.pub.ids)
}