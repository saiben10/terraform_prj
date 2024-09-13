
# output "dynamodb_table" {
#   value = aws_dynamodb_table.db.name
# }

# resource "aws_dynamodb_table" "db" {
#     name = var.dynamodb
#     hash_key = var.hash_key         # Primary key (partition key)
#     billing_mode   = "PROVISIONED"  # PROVISIONED billing mode
#     read_capacity  = var.read_capacity  # Must be at least 1
#     write_capacity = var.write_capacity # Must be at least 1

#   attribute {
#     name = var.hash_key                 # The name of the hash key
#     type = var.hash_key_type            # Type: "S" for string, "N" for number, "B" for binary
#   }


# }

resource "aws_dynamodb_table" "db" {
  name        = "demo-dynamo"
  hash_key    = "LockID"
  billing_mode = "PROVISIONED"
  read_capacity = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }
}

# variable "hash_key_type" {
#   description = "Type of the primary key (S for String, N for Number)"
#   type        = string
# }
