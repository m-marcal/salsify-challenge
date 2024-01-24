resource "aws_ecs_cluster" "cluster" {
  name = var.ecs_cluster_name
}


resource "aws_ecs_task_definition" "task" {
  family                   = "${var.project_name}-ecs-task-gifmachine"
  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_execution_role.arn

  container_definitions    = jsonencode([{
    name   = var.container_name
    image  = "${aws_ecr_repository.repository.repository_url}:latest"
    memory = 512,
    cpu    = 100,
    essential = true
    portMappings = [{
      hostPort = 0
      containerPort = var.container_port
      protocol      = "tcp"
    }]
    environment = [
      { name = "DATABASE_URL", value = var.database_url },
      { name = "RACK_ENV", value = var.rack_env },
      { name = "GIFMACHINE_PASSWORD", value = var.gifmachine_password }
    ]
  }])

}

resource "aws_ecs_service" "service" {
  
  depends_on = [aws_iam_role.ecs_execution_role]
  
  name            = "${var.project_name}-ecs-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "EC2"
  iam_role        = aws_iam_role.ecs_execution_role.name
  desired_count = 2
  

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }


  #####
  # deployment specifc
  #####
  
  # update tasks to use a newer Docker image with same image/tag combination (e.g., myimage:latest)
  force_new_deployment = true
  deployment_circuit_breaker {
    enable = true
    rollback = true # When a service deployment fails, the service is rolled back to the last deployment that completed successfully.
  }

}