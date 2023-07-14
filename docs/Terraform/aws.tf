data "aws_iam_policy_document" "example" {
  statement {
    sid = "1"
    effect   = "Allow"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
      "*",
    ]
    resources = [
      "arn:aws:s3:::*",
      "*"
  }

  statement {
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}",
    ]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"

      values = [
        "",
        "home/",
        "home/&{aws:username}/",
      ]
    }
  }

  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/home/&{aws:username}",
      "arn:aws:s3:::${var.s3_bucket_name}/home/&{aws:username}/*",
    ]
  }
}

resource "aws_iam_policy" "example" {
  name   = "example_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.example.json
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

# Create an Elasticsearch/OpenSearch domain with encryption at rest enabled
resource "aws_elasticsearch_domain" "example" {
  domain_name           = "example-domain"
  elasticsearch_version = "7.10"

  encrypt_at_rest {
    enabled = true
  }

  node_to_node_encryption_options {
    enabled = true
  }

  # Other configuration options can be added here
}

resource "aws_opensearch_domain" "example" {
  domain_name           = "example-domain"
  elasticsearch_version = "7.10"

  encrypt_at_rest {
    enabled = false
  }

  node_to_node_encryption_options {
    enabled = true
  }

}

resource "aws_kms_key" "example" {
  description             = "Example key for testing"
  deletion_window_in_days = 30
  enable_key_rotation     = false
}

resource "aws_ebs_volume" "example_ebs_volume" {
  availability_zone = "us-west-2a"
  size              = 100
  encrypted         = false
  snapshot_id       = "snap-0123456789abcdef"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  key_name      = "example-key"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    encrypted             = true
    kms_key_id            = aws_kms_key.example.key_id
    delete_on_termination = true
  }

  tags = {
    Name = "example-instance"
  }

  user_data = "access_key=123456ABCDEFGHIJZTLA and secret_key=AAAaa+Aa4AAaAA6aAkA0Ad+Aa8aA1aaaAAAaAaA"
}

resource "aws_iam_account_password_policy" "example" {
  minimum_password_length           = 8
  require_lowercase_characters     = true
  require_uppercase_characters     = true
  require_numbers                   = true
  require_symbols                   = true
  allow_users_to_change_password    = true
  max_password_age                  = 91
  password_reuse_prevention      = 24
}
resource "aws_sns_topic" "example_sns_topic" {
  name = "example-topic"
  #kms_master_key_id = "arn:aws:kms:us-west-2:123456789012:key/abcd1234-5678-90ab-cdef-ghlmnopqr"
}

resource "aws_sqs_queue" "example_sqs_queue" {
  name                        = "example-queue"
  # kms_master_key_id           = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300
  fifo_queue                  = false
  content_based_deduplication = false
  delay_seconds               = 0
  maximum_message_size        = 262144
  message_retention_seconds   = 345600
  receive_wait_time_seconds   = 0
  redrive_policy              = jsonencode({
    deadLetterTargetArn = aws_sns_topic.example_sns_topic.arn
    maxReceiveCount = 3
  })
}

resource "aws_db_instance" "example" {
  # Enable encryption at rest
  storage_encrypted       = false
  publicly_accessible     = true
  kms_key_id              = aws_kms_key.example.id
}

resource "aws_neptune_cluster" "example" {
  cluster_identifier = "example-cluster"
  storage_encrypted  = true
}

resource "aws_lambda_function" "example" {
  function_name = "example-function"
  handler      = "example.handler"
  runtime      = "nodejs14.x"
  role         = aws_iam_role.example.arn

  tracing_config {
    mode = "Active"
  }
  
  region = var.region
  access_key = "NOTEXACTLYAKEY"
  secret_key = "NOTACTUALLYASECRET"

  user_data     = <<-EOF
    #!/bin/bash
    echo "This is my user data script"
    access_key = "AKIAEXAMPLE"
    secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
    some_other_command
  EOF
   
}

resource "aws_kinesis_stream" "example" {
  name             = "example-stream"
  shard_count      = 1
  encryption_type  = "KMS"
}

resource "aws_efs_file_system" "example" {
  creation_token        = "example-efs"
  encrypted             = true
  performance_mode      = "generalPurpose"
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  tags = {
    Name = "example-efs"
  }
}

resource "aws_mq_broker" "example" {
  name                   = "example-broker"
  engine_type            = "ActiveMQ"
  engine_version         = "5.15.12"
  host_instance_type     = "mq.t2.micro"
  publicly_accessible    = false
  auto_minor_version_upgrade = true

  configuration {
    id       = "default-configuration"
    revision = 1
  }

  logs {
    general = true
  }

  tags = {
    Name = "example-mq-broker"
  }
}

resource "aws_security_group" "examplea" {
  name        = var.es_domain
  description = "Allow inbound traffic to ElasticSearch from VPC CIDR"
  vpc_id      = var.vpc
}

resource "aws_iam_policy_document" "example" {
  statement {
    actions = [
      "ec2:Describe*",
      "s3:Get*",
      "s3:List*",
      "sns:*",
    ]

    resources = ["*"]

    # Make sure the actions list does not contain '*'
    condition {
      test = "StringNotEquals"
      variable = "aws:PrincipalType"
      values = ["AWSService"]
    }
  }
}

resource "aws_dax_cluster" "example" {
  cluster_name = "example-dax-cluster"
  node_type    = "dax.r4.large"
  replication_factor = 2

  server_side_encryption {
    enabled = true
  }

  # other configuration for the DAX cluster
}

resource "aws_ecr_repository" "example" {
  name                 = "bar"
 image_tag_mutability = "IMMUTABLE"
}
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

provider "aws" {
  region = var.region
  access_key = "AKIAEXAMPLE"
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

resource "aws_eks_cluster" "my_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.cluster_role.arn

  # Enable secrets encryption
  encryption_config {
    provider = "aws-kms"

    resources {
      secrets {
        enabled = true
      }
    }
  }
}

resource "aws_api_gateway_method" "example" {
  http_method   = "GET"
  authorization = "NONE"
  api_key_required = false

  integration {
    http_method             = "POST"
    type                    = "AWS"
    integration_http_method = "POST"
  }
}

resource "aws_athena_database" "example" {

  encryption_configuration {
    
  }
}

resource "aws_ecs_cluster" "example" {

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_iam_role_policy" "example" {
  name   = "example"
  path   = "/"
  policy = <<POLICY
{
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}
POLICY
}

resource "aws_iam_user_policy" "example" {
  name   = "example_policy"
  user   = aws_iam_user.example.name
  policy = <<POLICY
{
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "example" {
  name = "example_role"
  
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}



resource "aws_iam_role" "example" {
  name = "example_role"

  assume_role_policy = <<EOF
{
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_redshift_cluster" "example" {


  encrypted = true
}

resource "aws_ecr_repository_policy" "example" {
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "ecr:*",
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_cloudwatch_log_group" "example" {
  name = "example"
 retention_in_days = 90
}
resource "aws_cloudtrail" "foobar" {
  name                          = "tf-trail-foobar"
  s3_bucket_name                = aws_s3_bucket.foo.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  is_multi_region_trail = true
}
resource "aws_ebs_encryption_by_default" "example" {
  enabled = true
}