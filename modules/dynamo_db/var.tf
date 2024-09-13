

variable "dynamodb" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "The primary key for the DynamoDB table"
  type        = string
}

variable "hash_key_type" {
  description = "Type of the primary key (S for String, N for Number)"
  type        = string
}

variable "read_capacity" {
  description = "Read capacity units for the table"
  type        = number
}

variable "write_capacity" {
  description = "Write capacity units for the table"
  type        = number
}
