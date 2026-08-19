# tfmodule-aws-alb

AWS (Application | Network) Load Balancer 를 생성 하는 테라폼 모듈 입니다.

## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.frontend_http_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.frontend_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_certificate.https_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_certificate) | resource |
| [aws_lb_listener_rule.http_tcp_listener_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.https_listener_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |


## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_access_logs"></a> [access\_logs](#input\_access\_logs) | Map containing access logging configuration for load balancer.<br/><br/>  access\_logs = {<br/>      enabled = true<br/>      bucket  = "<PREFIX>-alb-access-logs-s3"<br/>      prefix  = "AWSLogs/<ACCOUNT\_ID>/elasticloadbalancing/<REGION>/"<br/>  } | `map(string)` | `{}` | no |
| <a name="input_context"></a> [context](#input\_context) | Provides standardized naming policy and attribute information for data source reference to define cloud resources for a Project. | <pre>object({<br/>    project     = string<br/>    name_prefix = string<br/>    domain      = string<br/>    pri_domain  = string<br/>    tags        = map(string)<br/>  })</pre> | n/a | yes |
| <a name="input_create_lb"></a> [create\_lb](#input\_create\_lb) | Controls if the Load Balancer should be created | `bool` | `true` | no |
| <a name="input_drop_invalid_header_fields"></a> [drop\_invalid\_header\_fields](#input\_drop\_invalid\_header\_fields) | Indicates whether invalid header fields are dropped in application load balancers. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_cross_zone_load_balancing"></a> [enable\_cross\_zone\_load\_balancing](#input\_enable\_cross\_zone\_load\_balancing) | Indicates whether cross zone load balancing should be enabled in application load balancers. | `bool` | `false` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_http2"></a> [enable\_http2](#input\_enable\_http2) | Indicates whether HTTP/2 is enabled in application load balancers. | `bool` | `true` | no |
| <a name="input_enforce_security_group_inbound_rules_on_private_link_traffic"></a> [enforce\_security\_group\_inbound\_rules\_on\_private\_link\_traffic](#input\_enforce\_security\_group\_inbound\_rules\_on\_private\_link\_traffic) | Indicates whether inbound security group rules are enforced for traffic originating from a PrivateLink. Only valid for Load Balancers of type network. The possible values are on and off. | `string` | `"on"` | no |
| <a name="input_extra_ssl_certs"></a> [extra\_ssl\_certs](#input\_extra\_ssl\_certs) | A list of maps describing any extra SSL certificates to apply to the HTTPS listeners. Required key/values: certificate\_arn, https\_listener\_index (the index of the listener within https\_listeners which the cert applies toward). | `list(map(string))` | `[]` | no |
| <a name="input_http_tcp_listener_rules"></a> [http\_tcp\_listener\_rules](#input\_http\_tcp\_listener\_rules) | A list of maps describing the Listener Rules for this ALB. Required key/values: actions, conditions. Optional key/values: priority, http\_tcp\_listener\_index (default to http\_tcp\_listeners[count.index]) | `any` | `[]` | no |
| <a name="input_http_tcp_listener_rules_tags"></a> [http\_tcp\_listener\_rules\_tags](#input\_http\_tcp\_listener\_rules\_tags) | A map of tags to add to all http listener rules | `map(string)` | `{}` | no |
| <a name="input_http_tcp_listeners"></a> [http\_tcp\_listeners](#input\_http\_tcp\_listeners) | A list of maps describing the HTTP listeners or TCP ports for this ALB. Required key/values: port, protocol. Optional key/values: target\_group\_index (defaults to http\_tcp\_listeners[count.index]) | `any` | `[]` | no |
| <a name="input_http_tcp_listeners_tags"></a> [http\_tcp\_listeners\_tags](#input\_http\_tcp\_listeners\_tags) | A map of tags to add to all http listeners | `map(string)` | `{}` | no |
| <a name="input_https_listener_rules"></a> [https\_listener\_rules](#input\_https\_listener\_rules) | A list of maps describing the Listener Rules for this ALB. Required key/values: actions, conditions. Optional key/values: priority, https\_listener\_index (default to https\_listeners[count.index]) | `any` | `[]` | no |
| <a name="input_https_listener_rules_tags"></a> [https\_listener\_rules\_tags](#input\_https\_listener\_rules\_tags) | A map of tags to add to all https listener rules | `map(string)` | `{}` | no |
| <a name="input_https_listeners"></a> [https\_listeners](#input\_https\_listeners) | A list of maps describing the HTTPS listeners for this ALB. Required key/values: port, certificate\_arn. Optional key/values: ssl\_policy (defaults to ELBSecurityPolicy-2016-08), target\_group\_index (defaults to https\_listeners[count.index]) | `any` | `[]` | no |
| <a name="input_https_listeners_tags"></a> [https\_listeners\_tags](#input\_https\_listeners\_tags) | A map of tags to add to all https listeners | `map(string)` | `{}` | no |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | The time in seconds that the connection is allowed to be idle. | `number` | `60` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | Boolean determining if the load balancer is internal or externally facing. | `bool` | `false` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack. | `string` | `"ipv4"` | no |
| <a name="input_lb_name"></a> [lb\_name](#input\_lb\_name) | The name of Load Balancer | `string` | `null` | no |
| <a name="input_lb_tags"></a> [lb\_tags](#input\_lb\_tags) | A map of tags to add to load balancer | `map(string)` | `{}` | no |
| <a name="input_listener_ssl_policy_default"></a> [listener\_ssl\_policy\_default](#input\_listener\_ssl\_policy\_default) | The security policy if using HTTPS externally on the load balancer. [See](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-security-policy-table.html). | `string` | `"ELBSecurityPolicy-2016-08"` | no |
| <a name="input_load_balancer_create_timeout"></a> [load\_balancer\_create\_timeout](#input\_load\_balancer\_create\_timeout) | Timeout value when creating the ALB. | `string` | `"10m"` | no |
| <a name="input_load_balancer_delete_timeout"></a> [load\_balancer\_delete\_timeout](#input\_load\_balancer\_delete\_timeout) | Timeout value when deleting the ALB. | `string` | `"10m"` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | The type of load balancer to create. Possible values are `application` or `network`. | `string` | `"application"` | no |
| <a name="input_load_balancer_update_timeout"></a> [load\_balancer\_update\_timeout](#input\_load\_balancer\_update\_timeout) | Timeout value when updating the ALB. | `string` | `"10m"` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | The security groups to attach to the load balancer. e.g. ["sg-edcd9784","sg-edcd9785"] | `list(string)` | `[]` | no |
| <a name="input_subnet_mapping"></a> [subnet\_mapping](#input\_subnet\_mapping) | A list of subnet mapping blocks describing subnets to attach to network load balancer | `list(map(string))` | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnets to associate with the load balancer. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f'] | `list(string)` | `null` | no |
| <a name="input_target_group_tags"></a> [target\_group\_tags](#input\_target\_group\_tags) | A map of tags to add to all target groups | `map(string)` | `{}` | no |
| <a name="input_target_groups"></a> [target\_groups](#input\_target\_groups) | A list of maps containing key/value pairs that define the target groups to be created. Order of these maps is important and the index of these are to be referenced in listener definitions. Required key/values: name, backend\_protocol, backend\_port | `any` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id where the load balancer and other resources will be deployed. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_http_tcp_listener_arns"></a> [http\_tcp\_listener\_arns](#output\_http\_tcp\_listener\_arns) | The ARN of the TCP and HTTP load balancer listeners created. |
| <a name="output_http_tcp_listener_ids"></a> [http\_tcp\_listener\_ids](#output\_http\_tcp\_listener\_ids) | The IDs of the TCP and HTTP load balancer listeners created. |
| <a name="output_https_listener_arns"></a> [https\_listener\_arns](#output\_https\_listener\_arns) | The ARNs of the HTTPS load balancer listeners created. |
| <a name="output_https_listener_ids"></a> [https\_listener\_ids](#output\_https\_listener\_ids) | The IDs of the load balancer listeners created. |
| <a name="output_lb_arn"></a> [lb\_arn](#output\_lb\_arn) | The ID and ARN of the load balancer. |
| <a name="output_lb_arn_suffix"></a> [lb\_arn\_suffix](#output\_lb\_arn\_suffix) | ARN suffix of our load balancer - can be used with CloudWatch. |
| <a name="output_lb_dns_name"></a> [lb\_dns\_name](#output\_lb\_dns\_name) | The DNS name of the load balancer. |
| <a name="output_lb_id"></a> [lb\_id](#output\_lb\_id) | The ID and ARN of the load balancer. |
| <a name="output_lb_name"></a> [lb\_name](#output\_lb\_name) | The name of the load balancer. |
| <a name="output_lb_zone_id"></a> [lb\_zone\_id](#output\_lb\_zone\_id) | The zone\_id of the load balancer to assist with creating DNS records. |
| <a name="output_target_group_arn_suffixes"></a> [target\_group\_arn\_suffixes](#output\_target\_group\_arn\_suffixes) | ARN suffixes of our target groups - can be used with CloudWatch. |
| <a name="output_target_group_arns"></a> [target\_group\_arns](#output\_target\_group\_arns) | ARNs of the target groups. Useful for passing to your Auto Scaling group. |
| <a name="output_target_group_attachments"></a> [target\_group\_attachments](#output\_target\_group\_attachments) | ARNs of the target group attachment IDs. |
| <a name="output_target_group_names"></a> [target\_group\_names](#output\_target\_group\_names) | Name of the target group. Useful for passing to your CodeDeploy Deployment Group. |


## Usage

```
module "alb" {
  source = "git::https://code.bespinglobal.com/scm/op/tfmodule-aws-alb.git"

  context  = module.ctx.context
  lb_name = "pub"
  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = toset(module.vpc.public_subnets)
  security_groups = [ module.vpc.default_security_group_id ]

  http_tcp_listeners = [ {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    },]
  
  depends_on = [module.vpc]
}

module "vpc" {
  source = "git::https://code.bespinglobal.com/scm/op/tfmodule-aws-vpc.git"
  context  = module.ctx.context
  # ... You need to define resources for vpc ...
}

module "ctx" {
  source = "git::https://code.bespinglobal.com/scm/op/tfmodule-context.git"
  context = {  
    # ... You need to define context variables ...
  }
}
```

## 리소스 네이밍

로드 밸런서와 타겟 그룹의 실제 이름은 context 기반으로 자동 계산 됩니다. `name` 속성을 직접 지정하지 않습니다.

| 리소스 | 네이밍 규칙 | 예시 (name_prefix=demo-an2d, lb_name=pub) |
| ---- | ---- | ---- |
| Load Balancer | `{context.name_prefix}-{lb_name}-{alb\|nlb}` — `lb_name` 생략 시 `{context.name_prefix}-{alb\|nlb}` | `demo-an2d-pub-alb` |
| Target Group | `{context.project}-{target_groups[].name}` | `demo-web-tg80` |

접미사 `alb`/`nlb` 는 `load_balancer_type` 값(application/network)에 따라 자동 결정 됩니다.
모든 리소스 태그는 `context.tags` 를 기본으로 리소스별 태그 변수(`lb_tags`, `target_group_tags`, `https_listeners_tags` 등)와 개별 `tags` 가 병합 됩니다.

## ALB Sample
```
module "alb" {
  source = "git::https://code.bespinglobal.com/scm/op/tfmodule-aws-alb.git"

  context  = module.ctx.context
  lb_name = "pub"
  load_balancer_type = "application"

  vpc_id          = "${vpc_id}"
  subnets         = [ "${subnet_id}" ]
  security_groups = [ "${security_group_id}" ]
  # ...
}
```


## Access Logs Sample

로드 밸런서 액세스 로그를 S3 버킷에 적재 합니다. `bucket` 값이 설정 되면 `enabled` 를 생략해도 활성화 됩니다.
대상 S3 버킷에는 ELB 로그 전송을 허용하는 버킷 정책이 사전에 구성 되어 있어야 합니다.

```
  access_logs = {
    enabled = true
    bucket  = "<PREFIX>-alb-access-logs-s3"
    prefix  = "AWSLogs/<ACCOUNT_ID>/elasticloadbalancing/<REGION>"
  }
```

## NLB Sample
```
module "nlb" {
  source = "git::https://code.bespinglobal.com/scm/op/tfmodule-aws-alb.git"

  context  = module.ctx.context
  lb_name = "was"
  load_balancer_type = "network"

  vpc_id          = "${vpc_id}"
  subnets         = [ "${subnet_id}" ]
  # ...
}
```

## NLB Subnet Mapping Sample

network 타입 로드 밸런서는 `subnets` 대신 `subnet_mapping` 으로 가용 영역별 고정 IP (EIP) 또는 사설 IP 를 지정 할 수 있습니다.
지원 키: `subnet_id` (필수), `allocation_id`, `private_ipv4_address`, `ipv6_address`

```
  subnet_mapping = [
    {
      subnet_id     = "${public_subnet_id}"
      allocation_id = "${eip_allocation_id}"
    },
    {
      subnet_id            = "${private_subnet_id}"
      private_ipv4_address = "10.0.1.15"
    },
  ]
```

NLB 관련 옵션:

- `enable_cross_zone_load_balancing` : 교차 영역 로드 밸런싱 활성화 (기본값 false)
- `enforce_security_group_inbound_rules_on_private_link_traffic` : PrivateLink 트래픽에 대한 보안 그룹 인바운드 규칙 적용 여부 (`on` | `off`, 기본값 `on`, network 타입 전용)

## Target Group Sample

target_groups 속성 값의 설정을 통해 하나 이상의 대상 그룹을 정의 할 수 있습니다.  
target_group 의 하위 구성 요소로 health_check, targets 인스턴스를 선택적으로 구성 가능 합니다.

```
  target_groups = [
    {
      name                 = "web-tg80"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "ip"
    },
    {
      name                 = "was-tg8080"
      backend_protocol     = "HTTP"
      protocol_version     = "HTTP1"
      backend_port         = 8080
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        port                = "traffic-port"
        path                = "/health"
        interval            = 30
        healthy_threshold   = 2
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-302"
      }
      targets = {
        order1_ec2 = {
          target_id = data.aws_instance.order1_ec2.id
          port      = 8080
        },
        order2_ec2 = {
          target_id = data.aws_instance.order2_ec2.id
          port      = 8080
        }
      }            
    },
    {
      name                 = "postgres-tg5432"
      backend_protocol     = "TCP"
      backend_port         = 5432
      target_type          = "ip"
    },
  ]
```

## HTTP Listener Sample

로드 밸런서에 서비스 포트를 생성 합니다. 서비스 포트에 알맞은 타겟 그룹으로 보내거나 적절한 Response 응답을 정의 할 수 있습니다.

```
  [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    },
    {
      port        = 81
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    },
    {
      port        = 82
      protocol    = "HTTP"
      action_type = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed message"
        status_code  = "200"
      }
    },
  ]
```

## HTTP Listener Rules Sample

http_tcp_listener 리스너에 대한 라우팅 룰을 설정 합니다.

```
  [
    {
      http_tcp_listener_index = 0
      priority                = 3
      actions = [{
        type         = "fixed-response"
        content_type = "text/plain"
        status_code  = 200
        message_body = "This is a fixed response"
      }]
  
      conditions = [{
        http_headers = [{
          http_header_name = "x-Gimme-Fixed-Response"
          values           = ["yes", "please", "right now"]
        }]
      }]
    },
    {
      http_tcp_listener_index = 0
      priority                = 5000
      actions = [{
        type        = "redirect"
        status_code = "HTTP_302"
        host        = "www.youtube.com"
        path        = "/watch"
        query       = "v=dQw4w9WgXcQ"
        protocol    = "HTTPS"
      }]
  
      conditions = [{
        query_strings = [{
          key   = "video"
          value = "random"
        }]
      }]
    },
  ]
```

## HTTPS Listener Sample

로드 밸런서에 HTTPS 프로토콜 전용 서비스 포트를 생성 합니다. 서비스 포트에 알맞은 타겟 그룹으로 보내거나 적절한 Response 응답을 정의 할 수 있습니다.

```
  [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "acm_certificate_arn"
      target_group_index = 0
    },
  ]
```


## HTTPS Listener Rules Sample

로드 밸런서에 HTTPS 리스너를 위한 라우팅 룰을 정의 합니다.

```
  [
    {
      https_listener_index = 0
      priority             = 1
      actions = [{
        type         = "fixed-response"
        content_type = "text/plain"
        status_code  = 200
        message_body = "This is a fixed response"
      }]
    },
    {
      https_listener_index = 0
      priority             = 2
      actions = [{
          type               = "forward"
          target_group_index = 0
        }]
      conditions = [{
        path_patterns = ["/*"]
      }]
    },
    {
      https_listener_index = 0
      priority             = 3
      actions = [{
          type = "forward",
          target_group_index = 0
        }]
      conditions = [{
        host_headers = [ "www.your-public-domain", "api.your-public-domain"  ]
      }]
    },
  ]
```

## Extra SSL Certificates Sample

하나의 HTTPS 리스너에 SNI 용 추가 인증서를 연결 합니다. `https_listener_index` 는 https_listeners 목록에서 인증서를 적용 할 리스너의 인덱스 입니다.

```
  extra_ssl_certs = [
    {
      https_listener_index = 0
      certificate_arn      = "acm_extra_certificate_arn"
    },
  ]
```

## Weighted Forward Sample

https_listener_rules 의 `weighted-forward` 액션 타입으로 두 개 이상의 타겟 그룹에 가중치 기반 트래픽 분배 (블루/그린, 카나리 배포) 를 구성 합니다.
`stickiness` 는 선택 항목이며 지정된 시간 (초) 동안 동일 타겟 그룹으로 요청을 고정 합니다.

```
  https_listener_rules = [
    {
      https_listener_index = 0
      priority             = 10
      actions = [{
        type = "weighted-forward"
        target_groups = [
          {
            target_group_index = 0
            weight             = 90
          },
          {
            target_group_index = 1
            weight             = 10
          },
        ]
        stickiness = {
          enabled  = true
          duration = 3600
        }
      }]
      conditions = [{
        path_patterns = ["/*"]
      }]
    },
  ]
```

## HTTPS Listener Authentication Sample

HTTPS 리스너와 https_listener_rules 에서 `authenticate-cognito`, `authenticate-oidc` 인증 액션을 지원 합니다.
리스너 기본 액션에 인증을 구성 하면 인증 통과 후 `target_group_index` 의 타겟 그룹으로 forward 됩니다.

```
  https_listeners = [
    {
      port               = 443
      certificate_arn    = "acm_certificate_arn"
      action_type        = "authenticate-cognito"
      target_group_index = 0
      authenticate_cognito = {
        user_pool_arn       = "cognito_user_pool_arn"
        user_pool_client_id = "cognito_user_pool_client_id"
        user_pool_domain    = "cognito_user_pool_domain"
      }
    },
  ]
```

authenticate-oidc 는 `issuer`, `authorization_endpoint`, `token_endpoint`, `user_info_endpoint`, `client_id`, `client_secret` 키를 필수로 사용 합니다.

## Examples

`example` 디렉터리에서 실행 가능한 예제를 제공 합니다.

| 경로 | 설명 |
| ---- | ---- |
| `example/simple` | ALB + 보안 그룹 기본 구성 (리스너 없음) |
| `example/alb-http` | HTTP 80 → HTTPS 301 리다이렉트, 8080 fixed-response 리스너 구성 |
| `example/alb-https` | HTTP 80 리다이렉트 + HTTPS 443 리스너 (ACM 인증서, fixed-response) 구성 |

```
cd example/simple
terraform init
terraform plan
```

예제 실행에는 AWS CLI 프로파일 (`terraform.tfvars` 의 `context.aws_profile`) 과 대상 계정의 VPC, 서브넷, ACM 인증서 등 data source 조회 환경이 필요 합니다.
 