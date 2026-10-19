resource "aws_ecs_cluster" "docker-cicd-ecs-cluster" {
    name = "docker-cicd-ecs-cluster"

  
}
resource "aws_ecs_task_definition" "docker-cicd-task" {
  family                   = "docker-cicd-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "docker-cicd-container"
      image     = "637423389066.dkr.ecr.ap-south-1.amazonaws.com/docker-cicd-aws:v1"
      essential = true

      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}
resource "aws_ecs_service" "docker-cicd-service" {
  name            = "docker-cicd-service"
  cluster         = aws_ecs_cluster.docker-cicd-ecs-cluster.id
  task_definition = aws_ecs_task_definition.docker-cicd-task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.docker-cicd-public-1.id,
      aws_subnet.docker-cicd-public-2.id
    ]

    security_groups = [
      aws_security_group.docker-cicd-sg.id
    ]

    assign_public_ip = true
  }
}