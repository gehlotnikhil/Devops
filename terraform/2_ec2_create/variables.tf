variable aws_root_default_storage_size{
    default = 15
    type = number
}
variable aws_default_instance_type{
    default = "t3.micro"
    type = string
}

variable env{
    default = "production"
    type = string
}