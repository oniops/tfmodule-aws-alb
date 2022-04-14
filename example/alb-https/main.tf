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

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect    = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    },
  ]

  https_listeners = [
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = data.aws_acm_certificate.this.arn,
      ssl_policy      = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06",
      action_type     = "fixed-response",
      fixed_response = {
        content_type = "text/plain"
        message_body = "Service Unavailable"
        status_code  = "503"
      }
    },
  ]

  depends_on = [module.ctx]
}
