resource "aws_security_group" "TF_SG" {
  name        = "securitygrp_tf"
  vpc_id      = aws_vpc.myvpc.id
 
}

resource "aws_vpc_security_group_ingress_rule" "SSH" {
  security_group_id = aws_security_group.TF_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "HTTP" {
  security_group_id = aws_security_group.TF_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "HTTPS" {
  security_group_id = aws_security_group.TF_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.TF_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}


resource "aws_instance" "My_Instance" {
   ami           = "ami-06c68f701d8090592"
   instance_type = "t3.micro"
   key_name      = "janaki"
   vpc_security_group_ids = [aws_security_group.TF_SG.id]
   subnet_id      = aws_subnet.publicsubnet.id
   associate_public_ip_address = true
   user_data=file("script.sh")
  
   
    
   tags = {

     Name = "Instance2"
   }

   
  
}

  

