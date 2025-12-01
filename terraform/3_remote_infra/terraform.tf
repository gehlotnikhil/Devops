terraform{
  backend "s3"{
  bucket = "tws-state-bucket-10"
  key = "terraform.tfstate"
  region =   "ap-south-1"
  dynamodb_table = "tws-state-table-10"
  workspace_key_prefix = "workspace"

}
 required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.23.0"
    }
  }	
  
}

