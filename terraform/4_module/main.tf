# create key-pair
resource aws_key_pair my_key {
  key_name   = "terra-${var.env}"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKFn88JxNEAj6uheyQLN9Jj47ozqpY0ZtSvt2jclIDYM ubuntu@ip-172-31-15-176"
}

resource "aws_security_group" "my_security_group" {
  name        = "auto-${var.env}"
  description = "this is automate terrform sg group"
  vpc_id      =  module.vpc.vpc_id  #interpolation
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
    Name = "auto-sg-${var.env}"
    Environment = var.env
  }
}


# create aws ec2 instance


resource aws_instance my_instance{
    count = 3
    key_name = aws_key_pair.my_key.key_name
    vpc_security_group_ids = [aws_security_group.my_security_group.id]

  subnet_id = module.vpc.public_subnets[count.index % length(module.vpc.public_subnets)]
 instance_type = "t2.micro"
    ami = "ami-0d176f79571d18a8f"
    root_block_device {
      volume_size = 15
      volume_type = "gp3"
    }
    tags = {
        Name = "AK-47-${count.index}"
        Environment = var.env
    }
}