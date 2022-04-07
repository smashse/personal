## Requirements

| Name                                                   | Version |
| ------------------------------------------------------ | ------- |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | ~> 4.0  |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | ~> 4.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                  | Type     |
| --------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone)     | resource |
| [aws_s3_bucket.tfstate_shared](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_object.terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object)      | resource |

## Inputs

| Name                                                               | Description                        | Type     | Default       | Required |
| ------------------------------------------------------------------ | ---------------------------------- | -------- | ------------- | :------: |
| <a name="input_aws_profile"></a> [aws_profile](#input_aws_profile) | AWS profile used for all resources | `string` | `""`          |    no    |
| <a name="input_aws_region"></a> [aws_region](#input_aws_region)    | AWS region used for all resources  | `string` | `"us-east-1"` |    no    |

## Outputs

| Name                                                                 | Description |
| -------------------------------------------------------------------- | ----------- |
| <a name="output_bucket_name"></a> [bucket_name](#output_bucket_name) | n/a         |
| <a name="output_zone_id"></a> [zone_id](#output_zone_id)             | n/a         |

## For validation tests [click here](TEST_ENV.md).
