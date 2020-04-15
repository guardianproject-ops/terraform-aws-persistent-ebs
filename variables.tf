variable "az" {
  description = "The AWS Availability Zone (AZ) to create the instance in"
  type        = string
}

variable "volume_type" {
  default     = "gp2"
  description = "Type of EBS volume to use for the EBS block device"
  type        = string
}

variable "size" {
  description = "Size (in GB) of EBS volume to use for the EBS block device"
  type        = number
}

variable "snapshot_id" {
  default     = ""
  description = "The ID of the snapshot to base the EBS block device on"
  type        = string
}

variable "encrypted" {
  default     = true
  description = "Whether or not to encrypt the EBS block device"
  type        = bool
}

variable "kms_key_id" {
  default     = ""
  description = "ID of the KMS key to use when encrypting the EBS block device"
  type        = string
}

variable "iops" {
  default     = ""
  description = "The amount of IOPS to provision for the EBS block device"
  type        = string
}

