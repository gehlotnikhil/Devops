terraform{
  backend "s3"{
  bucket = "tws-state-bucket-10"
  key = "module_prac/terraform.tfstate"
  region =   "ap-south-1"
  dynamodb_table = "tws-state-table-1"
  workspace_key_prefix = "module_prac/workspace"

}
 required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.23.0"
    }
  }	
  
}

