resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "tws-state-table-10"
  # billing_mode = "PROVISIONED" means it is fully active and get bill according to how much we leave it activated
  billing_mode   = "PAY_PER_REQUEST" 
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

 

  tags = {
    Name        = "tws-state-table"
    Environment = "production"
  }
}