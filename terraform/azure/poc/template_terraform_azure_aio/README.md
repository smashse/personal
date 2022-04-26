## Requirements

| Name                                                               | Version |
| ------------------------------------------------------------------ | ------- |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | ~> 3.0  |

## Providers

| Name                                                            | Version |
| --------------------------------------------------------------- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm)    | ~> 3.0  |
| <a name="provider_random"></a> [random](#provider_random)       | n/a     |
| <a name="provider_template"></a> [template](#provider_template) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                                                  | Type        |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [azurerm_dns_a_record.ws](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record)                                                                               | resource    |
| [azurerm_dns_cname_record.grafana](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record)                                                                  | resource    |
| [azurerm_dns_cname_record.kubenav](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record)                                                                  | resource    |
| [azurerm_dns_cname_record.prometheus](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record)                                                               | resource    |
| [azurerm_dns_zone.zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone)                                                                                     | resource    |
| [azurerm_linux_virtual_machine.microk8s_control_instance](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine)                                      | resource    |
| [azurerm_network_interface.microk8s_control_ni](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface)                                                    | resource    |
| [azurerm_network_interface_security_group_association.microk8s_control](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource    |
| [azurerm_network_security_group.microk8s_control_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group)                                         | resource    |
| [azurerm_public_ip.microk8s_control_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip)                                                                   | resource    |
| [azurerm_resource_group.template_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)                                                                  | resource    |
| [azurerm_storage_account.template_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)                                                                | resource    |
| [azurerm_storage_container.tfstate_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container)                                                      | resource    |
| [azurerm_storage_container.velero_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container)                                                       | resource    |
| [azurerm_subnet.template_sn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)                                                                                  | resource    |
| [azurerm_virtual_network.template_vn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)                                                                | resource    |
| [random_id.template_rid](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id)                                                                                           | resource    |
| [template_file.microk8s_control_template](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)                                                                   | data source |

## Inputs

| Name                                                                                                                           | Description                           | Type     | Default       | Required |
| ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------- | -------- | ------------- | :------: |
| <a name="input_azure_location"></a> [azure_location](#input_azure_location)                                                    | Azure location used for all resources | `string` | `"centralus"` |    no    |
| <a name="input_microk8s_control_instance_count"></a> [microk8s_control_instance_count](#input_microk8s_control_instance_count) | Instance count                        | `string` | `"1"`         |    no    |

## Outputs

| Name                                                                                                                                   | Description |
| -------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| <a name="output_azurerm_resource_group"></a> [azurerm_resource_group](#output_azurerm_resource_group)                                  | n/a         |
| <a name="output_azurerm_storage_account"></a> [azurerm_storage_account](#output_azurerm_storage_account)                               | n/a         |
| <a name="output_azurerm_storage_container_tfstate"></a> [azurerm_storage_container_tfstate](#output_azurerm_storage_container_tfstate) | n/a         |
| <a name="output_azurerm_storage_container_velero"></a> [azurerm_storage_container_velero](#output_azurerm_storage_container_velero)    | n/a         |
| <a name="output_dns_zone"></a> [dns_zone](#output_dns_zone)                                                                            | n/a         |
| <a name="output_endpoints"></a> [endpoints](#output_endpoints)                                                                         | n/a         |
| <a name="output_microk8s_control_instance"></a> [microk8s_control_instance](#output_microk8s_control_instance)                         | n/a         |


# [Setting up the environment and POC](./setup.md)