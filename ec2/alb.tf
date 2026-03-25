# -------------------------------
# Application Load Balancer (ALB)
# -------------------------------
resource "aws_lb" "alb" {
  name               = "app-alb"
  load_balancer_type = "application"
  internal           = false

  subnets = [
    var.public_subnet_1_id,
    var.public_subnet_2_id
  ]

  security_groups = [var.alb_sg_id]

  tags = {
    Name = "app-alb"
  }
}

# -------------------------------
# Target Group
# -------------------------------
resource "aws_lb_target_group" "tg" {
  name     = "app-tg"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  tags = {
    Name = "app-tg"
  }
}

# -------------------------------
# Listener
# -------------------------------
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}