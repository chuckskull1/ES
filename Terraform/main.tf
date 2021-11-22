variable "ami"{
 description = "Ami-id for EC2 instance"  
}
variable "instance_type"{
 description = "Instance type for EC2 instance"  
}
variable "subnet_id"{
 description = "subnet id to launch EC2 instance in"  
}
variable "vpc_id"{
 description = "vpc id to for security group"  
}


resource "aws_instance" "ES_Instance" {
     ami = var.ami
     instance_type = var.instance_type
     iam_instance_profile = "${aws_iam_instance_profile.es_profile.name}"
     user_data = "${file("es.sh")}"
     security_groups = ["${aws_security_group.SG_ES.id}"]
     associate_public_ip_address = true
     subnet_id = var.subnet_id
 }
 resource "aws_security_group" "SG_ES" {
  name        = "ES-SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "All traffic supported"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Allow all"
  }
}

resource "aws_iam_role" "es_role" {
  name = "es_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "es_profile" {
  name = "es_profile2"
  role = "${aws_iam_role.es_role.name}"
}

resource "aws_iam_role_policy" "s3_policy" {
  name = "s3_policy"
  role = "${aws_iam_role.es_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Get*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
