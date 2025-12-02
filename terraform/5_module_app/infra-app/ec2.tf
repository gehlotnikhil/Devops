# create key-pair
resource aws_key_pair my_key {
  key_name   = "${var.env}-infra-app-key"
  public_key = file("terra-key.pub")
  tags = {
    Environment = var.env
  }
}


#  create VPC/Security Group

resource aws_default_vpc default{

} 

resource "aws_security_group" "my_security_group" {
  name        = "${var.env}-infra-app-sg"
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
    Name = "${var.env}-infra-app-sg"
    Environment = var.env
  }
}


# create aws ec2 instance


resource aws_instance my_instance{
    count = var.instance_count
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = var.instance_type
    ami = var.ami_id
    root_block_device {
      volume_size = var.env == "prd" ? 20:10
      volume_type = "gp3"
    }
    tags = {
        Name = "${var.env}-infra-app-instance-${count.index}"
        Environment = var.env
    }
}