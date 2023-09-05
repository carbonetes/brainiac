package lib.terraform.CB_TFAWS_315

test_ecs_service_fargate_latest_passed {
	result := passed with input as [
    {
        "Type": "provider",
        "Labels": [
            "aws"
        ],
        "Attributes": {
            "region": "us-west-2"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_ecs_task_definition",
            "example_task"
        ],
        "Attributes": {
            "execution_role_arn": "aws_iam_role.ecs_execution_role.arn",
            "family": "example-task",
            "network_mode": "awsvpc",
            "requires_compatibilities": [
                "FARGATE"
            ]
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 5
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_iam_role",
            "ecs_execution_role"
        ],
        "Attributes": {
            "name": "ecs_execution_role"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 34,
            "startLine": 19
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_ecs_service",
            "example_service"
        ],
        "Attributes": {
            "cluster": "aws_ecs_cluster.example_cluster.id",
            "launch_type": "FARGATE",
            "name": "example-service",
            "platform_version": "LATEST",
            "task_definition": "aws_ecs_task_definition.example_task.arn"
        },
        "Blocks": [
            {
                "Type": "network_configuration",
                "Labels": [],
                "Attributes": {
                    "subnets": [
                        "subnet-abc123",
                        "subnet-def456"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 45,
                    "startLine": 43
                }
            }
        ],
        "line_range": {
            "endLine": 48,
            "startLine": 36
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_ecs_cluster",
            "example_cluster"
        ],
        "Attributes": {
            "name": "example-cluster"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 52,
            "startLine": 50
        }
    }
]
	count(result) == 1
}

test_ecs_service_fargate_latest_failed {
	result := failed with input as [
    {
        "Type": "provider",
        "Labels": [
            "aws"
        ],
        "Attributes": {
            "region": "us-west-2"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_ecs_task_definition",
            "example_task"
        ],
        "Attributes": {
            "execution_role_arn": "aws_iam_role.ecs_execution_role.arn",
            "family": "example-task",
            "network_mode": "awsvpc",
            "requires_compatibilities": [
                "FARGATE"
            ]
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 5
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_iam_role",
            "ecs_execution_role"
        ],
        "Attributes": {
            "name": "ecs_execution_role"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 34,
            "startLine": 19
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_ecs_service",
            "example_service"
        ],
        "Attributes": {
            "cluster": "aws_ecs_cluster.example_cluster.id",
            "launch_type": "FARGATE",
            "name": "example-service",
            "platform_version": "NOT_LATEST",
            "task_definition": "aws_ecs_task_definition.example_task.arn"
        },
        "Blocks": [
            {
                "Type": "network_configuration",
                "Labels": [],
                "Attributes": {
                    "subnets": [
                        "subnet-abc123",
                        "subnet-def456"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 45,
                    "startLine": 43
                }
            }
        ],
        "line_range": {
            "endLine": 48,
            "startLine": 36
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_ecs_cluster",
            "example_cluster"
        ],
        "Attributes": {
            "name": "example-cluster"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 52,
            "startLine": 50
        }
    }
]
	count(result) == 1
}