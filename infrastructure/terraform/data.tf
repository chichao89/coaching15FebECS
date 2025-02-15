data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_cloudwatch_log_group" "ecs_log_group" {
  name = "/aws/ecs/chichao-task/chichao-container"
}
