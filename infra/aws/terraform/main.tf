resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "aws_iam_role" "beanstalk_role" {
  name = "beanstalk-role-${var.app_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = {
    Name = "beanstalk-role-${var.app_name}"
  }
}

resource "aws_iam_role_policy_attachment" "beanstalk_role_policy_attachment" {
  role       = aws_iam_role.beanstalk_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_instance_profile" "beanstalk_instance_profile" {
  name = aws_iam_role.beanstalk_role.name
  role = aws_iam_role.beanstalk_role.name
}

resource "aws_elastic_beanstalk_application" "beanstalk_app" {
  name        = "eb-${var.app_name}-${var.env}"
  description = "Elastic Beanstalk Application"
}

resource "aws_elastic_beanstalk_environment" "beanstalk_env" {
  name                = "eb-env-${var.app_name}-${var.env}"
  application         = aws_elastic_beanstalk_application.beanstalk_app.name
  solution_stack_name = "64bit Amazon Linux 2 v5.9.3 running Node.js 18" # Adjust Node.js version as needed

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro" # Instance type for the environment
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.beanstalk_instance_profile.name
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "NODE_ENV"
    value     = "production"
  }
}
