terraform{
 required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.23.0"
    }
  }	
  backend "s3"{
  bucket = "tws-state-bucket-73571"
  key = "state/${var.env}/terraform.tfstate"
  region =   "ap-south-1"
  dynamodb_table = "tws-state-table"
}
}

