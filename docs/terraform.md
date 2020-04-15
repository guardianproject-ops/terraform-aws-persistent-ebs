## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| attributes | Additional attributes (e.g., `one', or `two') | `list` | `[]` | no |
| az | The AWS Availability Zone (AZ) to create the instance in | `string` | n/a | yes |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name`, and `attributes` | `string` | `"-"` | no |
| encrypted | Whether or not to encrypt the EBS block device | `bool` | `true` | no |
| iops | The amount of IOPS to provision for the EBS block device | `string` | `""` | no |
| kms\_key\_id | ID of the KMS key to use when encrypting the EBS block device | `string` | `""` | no |
| name | Name  (e.g. `app` or `database`) | `string` | n/a | yes |
| namespace | Namespace (e.g. `org`) | `string` | n/a | yes |
| size | Size (in GB) of EBS volume to use for the EBS block device | `number` | n/a | yes |
| snapshot\_id | The ID of the snapshot to base the EBS block device on | `string` | `""` | no |
| stage | Environment (e.g. `test`, `dev`) | `string` | n/a | yes |
| tags | Additional tags (e.g. map(`Visibility`,`Public`) | `map` | `{}` | no |
| volume\_type | Type of EBS volume to use for the EBS block device | `string` | `"gp2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| ebs\_volume | n/a |
| iam\_policy | n/a |

