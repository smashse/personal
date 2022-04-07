## Requirements

| Name                                                   | Version |
| ------------------------------------------------------ | ------- |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | ~> 4.0  |

## Providers

| Name                                                            | Version |
| --------------------------------------------------------------- | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws)                | ~> 4.0  |
| <a name="provider_template"></a> [template](#provider_template) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                         | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_lightsail_domain.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_domain)                                                  | resource    |
| [aws_lightsail_instance.microk8s_control_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_instance)                           | resource    |
| [aws_lightsail_instance_public_ports.microk8s_control_kube](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_instance_public_ports)     | resource    |
| [aws_lightsail_key_pair.key_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_key_pair)                                          | resource    |
| [aws_lightsail_static_ip.microk8s_control_ip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_static_ip)                               | resource    |
| [aws_lightsail_static_ip_attachment.microk8s_control_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_static_ip_attachment) | resource    |
| [aws_route53_record.backstage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                                                   | resource    |
| [aws_route53_record.grafana](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                                                     | resource    |
| [aws_route53_record.prometheus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                                                  | resource    |
| [aws_route53_record.ws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                                                          | resource    |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone)                                                         | data source |
| [template_file.microk8s_control_template](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)                                          | data source |

## Inputs

| Name                                                                              | Description                                       | Type       | Default                                                                                                                                                                                                      | Required |
| --------------------------------------------------------------------------------- | ------------------------------------------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------: |
| <a name="input_aws_blueprint_id"></a> [aws_blueprint_id](#input_aws_blueprint_id) | OS used for Blueprint IDs                         | `map(any)` | <pre>{<br> "amazon": "amazon_linux_2",<br> "centos": "centos_7_1901_01",<br> "debian": "debian_10",<br> "opensuse": "opensuse_15_1",<br> "ubuntu": "ubuntu_20_04"<br>}</pre>                                 |    no    |
| <a name="input_aws_bundle_id"></a> [aws_bundle_id](#input_aws_bundle_id)          | Instance type used for all Bundle instances       | `map(any)` | <pre>{<br> "2xlarge": "2xlarge_2_0",<br> "large": "large_2_0",<br> "medium": "medium_2_0",<br> "micro": "micro_2_0",<br> "nano": "nano_2_0",<br> "small": "small_2_0",<br> "xlarge": "xlarge_2_0"<br>}</pre> |    no    |
| <a name="input_aws_profile"></a> [aws_profile](#input_aws_profile)                | AWS profile used for all resources                | `string`   | `""`                                                                                                                                                                                                         |    no    |
| <a name="input_aws_region"></a> [aws_region](#input_aws_region)                   | AWS region used for all resources                 | `string`   | `"us-east-1"`                                                                                                                                                                                                |    no    |
| <a name="input_aws_zone_id"></a> [aws_zone_id](#input_aws_zone_id)                | Availability zone name used for all EC2 instances | `map(any)` | <pre>{<br> "us-east-1": "us-east-1a",<br> "us-east-2": "us-east-2a"<br>}</pre>                                                                                                                               |    no    |
| <a name="input_domain_name"></a> [domain_name](#input_domain_name)                | n/a                                               | `string`   | `""`                                                                                                                                                                                                         |    no    |

## Outputs

| Name                                                                                                                                            | Description |
| ----------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| <a name="output_endpoints"></a> [endpoints](#output_endpoints)                                                                                  | n/a         |
| <a name="output_microk8s_control_instance_ip_address"></a> [microk8s_control_instance_ip_address](#output_microk8s_control_instance_ip_address) | n/a         |

## For validation tests [click here](TEST_ENV.md).
