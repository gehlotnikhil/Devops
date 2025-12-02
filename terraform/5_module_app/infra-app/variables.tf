variable "env"{
    description = "this is env for my infra"
}

variable "bucket_name"{
    description = "this is the bucket name"
    type = string
}

variable "instance_count"{
    description = "this is no. of ec2 instance"
    type = number
}
variable "instance_type"{
    description = "this is the instance type of ec2"
    type = string
}
variable "ami_id"{
    description = "this is the ami id of ec2"
    type = string
}
variable "hash_key"{
    description = "this is the hash_key of dynamodb"
    type = string
}
