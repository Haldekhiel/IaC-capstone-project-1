resource "aws_security_group" "redis_sg" {
  name   = "redis_sg"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "redis_allow_ssh" {
  security_group_id            = aws_security_group.redis_sg.id
  referenced_security_group_id = aws_security_group.bastion_sg.id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}
resource "aws_vpc_security_group_ingress_rule" "redis_allow_redisl" {
  security_group_id            = aws_security_group.redis_sg.id
  referenced_security_group_id = aws_security_group.http_sg.id
  from_port                    = 6379
  ip_protocol                  = "tcp"
  to_port                      = 6379
}

resource "aws_vpc_security_group_egress_rule" "redis_all_traffic_to_internet" {
  security_group_id = aws_security_group.redis_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
