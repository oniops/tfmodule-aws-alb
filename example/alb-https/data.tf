data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_availability_zones" "this" {
  state = "available"
}

data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["${module.ctx.name_prefix}-vpc"]
  }
}

data "aws_subnets" "pub" {

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  filter {
    name   = "tag:Name"
    values = [ format("%s-pub*", module.ctx.name_prefix) ]
  }

}

data "aws_acm_certificate" "this" {
  domain = "*.opsnow.kr"
}

