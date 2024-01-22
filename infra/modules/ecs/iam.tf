resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs.amazonaws.com"
        }
      },
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_instance_role_profile" {
  name = "${var.project_name}_EC2_InstanceRoleProfile"
  role = aws_iam_role.ecs_execution_role.name
}

resource "aws_iam_policy_attachment" "ecs_execution_role_policy" {
  name       = "ecs_execution_role_policy_attachment"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  roles      = [aws_iam_role.ecs_execution_role.name]
}

resource "aws_iam_policy_attachment" "ecs_container_service_role_policy" {
  name       = "ecs_container_service_role_policy_attachment"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
  roles      = [aws_iam_role.ecs_execution_role.name]
}

resource "aws_iam_policy_attachment" "ecs_task_execution_role_policy" {
  name       = "ecs_task_execution_role_policy_attachment"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  roles      = [aws_iam_role.ecs_execution_role.name]
}