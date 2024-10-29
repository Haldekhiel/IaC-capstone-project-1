resource "aws_instance" "redis" {
  ami           = var.amazon_linux_ami_id
  instance_type = "t3.micro"

  key_name = aws_key_pair.key.key_name

  vpc_security_group_ids = [aws_security_group.redis_sg.id]

  subnet_id = aws_subnet.private-b.id

  associate_public_ip_address = false
  user_data                   = file("redis_init.sh")
  tags = {
    Name = "redis"
  }
}

output "redis_private_ips" {
  value = aws_instance.redis.private_ip
}

