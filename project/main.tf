provider "aws" {
  region = "us-east-1"
}


module "private-network" {
  source            = "../modules/privateNetwork"
  vpc_id=aws_vpc.main.id
  public_subnet_id = module.public_network.public_subnet_ids[0]
}
module "public_network" {
  source   = "../modules/PublicNetwork"
  vpc_id=aws_vpc.main.id
}

module "ec2-private" {
  source = "../modules/ec2-private"
  vpc_id=aws_vpc.main.id
  private_subnet_ids = module.private-network.private_subnet_ids
  
  
}
module "ec2-public" {
    source = "../modules/ec2-public"
    vpc_id=aws_vpc.main.id
    public_subnet_ids = module.public_network.public_subnet_ids
    load_balancer_dns = module.load_balancer-private.load_balancer_dns
      depends_on      = [module.load_balancer-private]
      efs_id = module.EFS.efs_id

 
}
module "load_balancer-private" {
  source = "../modules/ELB-private"
  vpc_id=aws_vpc.main.id
  private_subnet_ids = module.private-network.private_subnet_ids
  private_security_group_id = module.ec2-private.private_security_group
  ec2_instance_ids-private = module.ec2-private.ec2_instance_ids-private
}
module "load_balancer-public" {
  source = "../modules/ELB-public"
  vpc_id=aws_vpc.main.id
  public_subnet_ids = module.public_network.public_subnet_ids
  ec2_instance_ids_public = module.ec2-public.ec2_instance_ids_public 
  public_security_group_id = module.ec2-public.public_security_group
}

# module "rds" {
#   source= "../modules/rds"
#   vpc_id=aws_vpc.main.id
#   private_subnet_ids = module.private-network.private_subnet_ids
#   depends_on = [ module.private-network]
# }

module "route53" {
  source          = "../modules/route53"
  alb_public_dns = module.load_balancer-public.alb_public_dns  
}
module "EFS" {
  source = "../modules/EFS"
   vpc_id=aws_vpc.main.id
  public_subnets = module.public_network.public_subnet_ids


}