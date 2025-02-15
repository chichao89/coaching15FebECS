module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.9.0"

  cluster_name = "${local.prefix}-ecs"

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  services = {
    "${local.task_name}" = {
      cpu    = 512
      memory = 1024
      container_definitions = {
        "${local.container_name}" = {
          essential = true
          image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${local.prefix}-ecr:latest"
          port_mappings = [
            {
              containerPort = 8080
              protocol      = "tcp"
            }
          ]
        }
      }
      assign_public_ip     = true
      subnet_ids           = [aws_subnet.public_subnet.id]  
      security_group_ids   = [aws_security_group.ecs_sg.id]  
    }
  }
}
