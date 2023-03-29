resource "aws_subnet" "pb-public-subnet" {
  vpc_id = "vpc-019c09a1a0c5b4f6b"
  cidr_block = "10.0.0.32/28"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "pb-public-subnet"
  }
}

resource "aws_security_group" "allow-ssh-port80" {
  name        = "allow-ssh-port80"
  description = "Allow ssh and port 80 inbound traffic"
  vpc_id      = "vpc-019c09a1a0c5b4f6b"
  ingress {
    description      = "Allow port 80 inbound"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow ssh inbound"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
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
    Name = "allow-ssh-port80"
  }
 
}

resource "aws_key_pair" "terraform-trial" {
  key_name = "terraform-trial-key"
  public_key = file("./create-instance/ssh-keys/terraform-trial.pub")
}


resource "aws_instance" "app_server" {
  ami           = "ami-00c39f71452c08778"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pb-public-subnet.id
  vpc_security_group_ids = [aws_security_group.allow-ssh-port80.id]
  key_name = aws_key_pair.terraform-trial.key_name
  tags = {
    Name = "pb-terraform-instance"
  }
}
