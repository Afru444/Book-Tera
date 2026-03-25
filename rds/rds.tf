resource "aws_db_subnet_group" "db_subnets" {
  name = "app-db-subnet-group"

  subnet_ids = [
    var.private_subnet_1_id,
    var.private_subnet_2_id
  ]
}

resource "aws_db_instance" "postgres" {
  identifier     = "app-postgres-db"
  engine         = "postgres"
  engine_version = "17.6"
  instance_class = "db.t3.micro"

  allocated_storage = 20

  db_name  = "postgres"
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [var.rds_sg_id]

  publicly_accessible = false
  skip_final_snapshot = true
}
