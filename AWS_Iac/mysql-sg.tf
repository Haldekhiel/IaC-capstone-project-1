resource "aws_security_group" "mysql_sg" {
  name   = "mysql_sg"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "mysql_allow_ssh" {
  security_group_id            = aws_security_group.mysql_sg.id
  referenced_security_group_id = aws_security_group.bastion_sg.id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}
resource "aws_vpc_security_group_ingress_rule" "mysql_allow_mysql" {
  security_group_id            = aws_security_group.mysql_sg.id
  referenced_security_group_id = aws_security_group.http_sg.id
  from_port                    = 3306
  ip_protocol                  = "tcp"
  to_port                      = 3306
}

resource "aws_vpc_security_group_egress_rule" "mysql_all_traffic_to_internet" {
  security_group_id = aws_security_group.mysql_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
