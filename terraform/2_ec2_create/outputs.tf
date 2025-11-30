output aws_instance_public_ip{
    # it is for when it give single output
    # value =  aws_instance.my_instance.public_ip
    # count give multiple value 
    # value =  aws_instance.my_instance[*].public_ip
    # for_each 
    value = [for key in aws_instance.my_instance: key.public_ip]
    
}
output aws_instance_public_dns{
    # value =  aws_instance.my_instance[*].public_ip
    value = [for key in aws_instance.my_instance: key.public_dns]
}
output aws_instance_private_ip{
    # value =  aws_instance.my_instance[*].private_ip
    value = [for key in aws_instance.my_instance: key.private_ip]
}