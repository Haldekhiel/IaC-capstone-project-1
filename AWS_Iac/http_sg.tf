resource "aws_security_group" "http_sg" {
  name   = "http_sg"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "http_allow_ssh" {
  security_group_id            = aws_security_group.http_sg.id
  referenced_security_group_id = aws_security_group.bastion_sg.id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}
resource "aws_vpc_security_group_ingress_rule" "http_allow_flask" {
  security_group_id            = aws_security_group.http_sg.id
  referenced_security_group_id = aws_security_group.nlb_sg.id
  from_port                    = 5000
  ip_protocol                  = "tcp"
  to_port                      = 5000
}

resource "aws_vpc_security_group_egress_rule" "http_all_traffic_to_internet" {
  security_group_id = aws_security_group.http_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
