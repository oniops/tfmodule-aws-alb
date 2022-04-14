module "ctx" {
  source  = "git::https://code.bespinglobal.com/scm/op/tfmodule-context.git"
  context = var.context
}

module "alb" {
  source = "../../"

  context            = module.ctx.context
  lb_name            = "pub"
  load_balancer_type = "application"

  vpc_id          = data.aws_vpc.this.id
  subnets         = toset(data.aws_subnets.pub.ids)
  security_groups = [aws_security_group.this.id]

  depends_on = [module.ctx]
}
