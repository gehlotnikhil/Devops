module "dev-infra"{
    source = "./infra-app"
    env = "dev"
    bucket_name = "infra-app-bucket-21"
    instance_count = 1
    instance_type = "t2.micro"
    ami_id = "ami-02b8269d5e85954ef"
    hash_key = "studentID"
}
module "stg-infra"{
    source = "./infra-app"
    env = "stg"
    bucket_name = "infra-app-bucket-21"
    instance_count = 2
    instance_type = "t2.small"
    ami_id = "ami-02b8269d5e85954ef"
    hash_key = "studentID"
}
module "prd-infra"{
    source = "./infra-app"
    env = "prd"
    bucket_name = "infra-app-bucket-21"
    instance_count = 1
    instance_type = "t2.medium"
    ami_id = "ami-02b8269d5e85954ef"
    hash_key = "studentID"
}