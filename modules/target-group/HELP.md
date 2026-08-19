<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_alb_listener_rule.http_path](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener_rule) | resource |
| [aws_alb_target_group.tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_autoscaling_attachment.attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_asg_name"></a> [asg\_name](#input\_asg\_name) | The name of the ASG (ASG) in the servers are deployed | `string` | n/a | yes |
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | The amount time for the Load Balancer to wait before changing the state of a deregistering server from draining to unused. The range is 0-3600 seconds. | `number` | `300` | no |
| <a name="input_enable_stickiness"></a> [enable\_stickiness](#input\_enable\_stickiness) | Set to true to enable stickiness, so a given user always gets routed to the same server. We recommend enabling this for the Couchbase Web Console. | `bool` | `false` | no |
| <a name="input_health_check_healthy_threshold"></a> [health\_check\_healthy\_threshold](#input\_health\_check\_healthy\_threshold) | The number of times the health check must pass before a server is considered healthy. | `number` | `2` | no |
| <a name="input_health_check_interval"></a> [health\_check\_interval](#input\_health\_check\_interval) | The approximate amount of time, in seconds, between health checks of each server. Minimum value 5 seconds, Maximum value 300 seconds. | `number` | `30` | no |
| <a name="input_health_check_matcher"></a> [health\_check\_matcher](#input\_health\_check\_matcher) | The HTTP codes to use when checking for a successful response from a server. You can specify multiple comma-separated values (for example, "200,202") or a range of values (for example, "200-299"). | `string` | `"200"` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | The path to use for health check requests. | `string` | n/a | yes |
| <a name="input_health_check_timeout"></a> [health\_check\_timeout](#input\_health\_check\_timeout) | The amount of time, in seconds, during which no response from a server means a failed health check. Must be between 2 and 60 seconds. | `number` | `5` | no |
| <a name="input_health_check_unhealthy_threshold"></a> [health\_check\_unhealthy\_threshold](#input\_health\_check\_unhealthy\_threshold) | The number of times the health check must fail before a server is considered unhealthy. | `number` | `2` | no |
| <a name="input_listener_arns"></a> [listener\_arns](#input\_listener\_arns) | The ARNs of ALB listeners to which Listener Rules that route to this Target Group should be added. | `list(string)` | n/a | yes |
| <a name="input_listener_rule_starting_priority"></a> [listener\_rule\_starting\_priority](#input\_listener\_rule\_starting\_priority) | The starting priority for the Listener Rules | `number` | n/a | yes |
| <a name="input_num_listener_arns"></a> [num\_listener\_arns](#input\_num\_listener\_arns) | The number of ARNs in var.listener\_arns. We should be able to compute this automatically, but due to a Terraform limitation, if there are any dynamic resources in var.listener\_arns, then we won't be able to: https://github.com/hashicorp/terraform/pull/11482 | `number` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | The port the servers are listening on for requests. | `number` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol to use to talk to the servers. Must be one of: HTTP, HTTPS. | `string` | `"HTTP"` | no |
| <a name="input_routing_condition"></a> [routing\_condition](#input\_routing\_condition) | This variable defines the paths or domain names that will be routed to the servers. By default, we route all paths and domain names to the servers. To override this, you should pass in a list of maps, where each map has the keys field and values. The field can be one of: path-pattern, host-header, http-request-method, or source-ip. The values are an array of values for that field. See the Condition Blocks documentation for the syntax to use: https://www.terraform.io/docs/providers/aws/r/lb_listener_rule.html. | <pre>list(object({<br/>    field  = string<br/>    values = list(string)<br/>  }))</pre> | <pre>[<br/>  {<br/>    "field": "path-pattern",<br/>    "values": [<br/>      "*"<br/>    ]<br/>  }<br/>]</pre> | no |
| <a name="input_stickiness_cookie_duration"></a> [stickiness\_cookie\_duration](#input\_stickiness\_cookie\_duration) | The time period, in seconds, during which requests from a client should be routed to the same target. After this time period expires, the load balancer-generated cookie is considered stale. The range is 1 second to 1 week (604800 seconds). Only used if var.enable\_stickiness is true. | `number` | `86400` | no |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | The name to use for the Target Group | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC in which to deploy the Target Group | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | n/a |
<!-- END_TF_DOCS -->