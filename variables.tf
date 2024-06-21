variable "key_name" {
  description = "Key name for SSH access"
  type        = string
}

variable "allowed_ip" {
  description = "IP address allowed to SSH into EC2 instance"
  type        = string
}
