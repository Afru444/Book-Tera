module "vpc" {
  source = "./vpc"

  region           = var.region
  vpc_cidr         = var.vpc_cidr
  public_subnet_1  = var.public_subnet_1
  public_subnet_2  = var.public_subnet_2
  private_subnet_1 = var.private_subnet_1
  private_subnet_2 = var.private_subnet_2
}

module "ec2" {
  source = "./ec2"

  vpc_id              = module.vpc.vpc_id
  public_subnet_1_id  = module.vpc.public_subnet_1_id
  public_subnet_2_id  = module.vpc.public_subnet_2_id
  private_subnet_1_id = module.vpc.private_subnet_1_id
  alb_sg_id           = module.vpc.alb_sg_id
  ec2_sg_id           = module.vpc.ec2_sg_id
  instance_type       = var.instance_type
  existing_s3_bucket  = data.aws_s3_bucket.existing_bucket.id
}

module "rds" {
  source = "./rds"

  private_subnet_1_id = module.vpc.private_subnet_1_id
  private_subnet_2_id = module.vpc.private_subnet_2_id
  rds_sg_id           = module.vpc.rds_sg_id
  db_username         = var.db_username
  db_password         = var.db_password
}
