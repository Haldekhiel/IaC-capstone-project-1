resource "aws_lb" "nlb" {
  name               = "nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.public-b.id]
  security_groups    = [aws_security_group.nlb_sg.id]
}

resource "aws_lb_target_group" "http" {
  name     = "http"
  port     = 5000
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    interval = 5
    timeout  = 2
    protocol = "TCP"
  }
}

resource "aws_lb_target_group_attachment" "http_nlb_link" {
  count            = length(aws_instance.http)
  target_group_arn = aws_lb_target_group.http.arn
  target_id        = aws_instance.http[count.index].id
  port             = 5000
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }
}

output "nlb_url" {
  value = aws_lb.nlb.dns_name
}
