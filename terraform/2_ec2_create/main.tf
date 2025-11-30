# create key-pair
resource aws_key_pair my_key {
  key_name   = "terra-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKFn88JxNEAj6uheyQLN9Jj47ozqpY0ZtSvt2jclIDYM ubuntu@ip-172-31-15-176"
}


#  create VPC/Security Group

resource aws_default_vpc default{

} 

resource "aws_security_group" "my_security_group" {
  name        = "auto-mate-tf"
  description = "this is automate terrform sg group"
  vpc_id      = aws_default_vpc.default.id  #interpolation
#   inbound rules(ingress)
    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress{
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress{
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "this is for flask app"
    }
# output rules(egress)
    egress{
        from_port = 0 
        to_port =  0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  tags = {
    Name = "auto-mate-tf"
  }
}


# create aws ec2 instance

resource aws_instance my_instance{
    for_each = tomap({
        "TWS-T3-MICRO" = "t3.micro"
        "TWS-T3-MEDIUM" = "t3.medium"
    })
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = each.value
    ami = "ami-02b8269d5e85954ef"
    user_data = file("install_nginx.sh")
    root_block_device {
      volume_size =  var.env == "production" ?20:var.aws_root_default_storage_size
      volume_type = "gp3"
    }
    tags = {
        Name = each.key
    }
}
# resource aws_instance my_instance{
#     count = 4
#     key_name = aws_key_pair.my_key.key_name
#     security_groups = [aws_security_group.my_security_group.name]
#     instance_type = var.aws_default_instance_type
#     ami = "ami-02b8269d5e85954ef"
#     root_block_device {
#       volume_size =  var.env == "production" ?20:var.aws_root_default_storage_size
#       volume_type = "gp3"
#     }
#     tags = {
#         Name = "AK-47"
#     }
# }


# resource aws_instance my_instance{
#     key_name = aws_key_pair.my_key.key_name
#     security_groups = [aws_security_group.my_security_group.name]
#     instance_type = "t2.micro"
#     ami = "ami-0d176f79571d18a8f"
#     root_block_device {
#       volume_size = 15
#       volume_type = "gp3"
#     }
#     tags = {
#         Name = "AK-47"
#     }
# }