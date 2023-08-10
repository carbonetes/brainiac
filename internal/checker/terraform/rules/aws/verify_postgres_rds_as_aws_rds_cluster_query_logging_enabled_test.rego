package lib.terraform.CB_TFAWS_322

test_aws_rds_query_logging_enabled {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": ["aws_rds_cluster_parameter_group", "example"],
            "Attributes": {
                "description": "Example Cluster Parameter Group for Postgres",
                "family": "aurora-postgresql",
                "name": "example-cluster-pg"
            },
            "Blocks": [
                {
                    "Type": "parameter",
                    "Attributes": {
                        "name": "log_statement",
                        "value": "all"
                    }
                },
                {
                    "Type": "parameter",
                    "Attributes": {
                        "name": "log_min_duration_statement",
                        "value": "0"
                    }
                }
            ]
        },
        {
            "Type": "resource",
            "Labels": ["aws_rds_cluster", "example"],
            "Attributes": {
                "availability_zones": ["us-east-1a", "us-east-1b"],
                "backup_retention_period": "7",
                "cluster_identifier": "example-cluster",
                "cluster_parameter_group_name": "aws_rds_cluster_parameter_group.example.name",
                "database_name": "exampledb",
                "db_subnet_group_name": "aws_db_subnet_group.example.name",
                "engine": "aurora-postgresql",
                "engine_mode": "provisioned",
                "master_password": "P@ssw0rd123",
                "master_username": "admin",
                "skip_final_snapshot": true,
                "vpc_security_group_ids": "aws_security_group.example.id"
            },
            "Blocks": [],
            "line_range": {"endLine": 30, "startLine": 17}
        }
    ]
	count(result) == 1
}

test_aws_rds_query_logging_not_enabled {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": ["aws_rds_cluster_parameter_group", "example"],
            "Attributes": {
                "description": "Example Cluster Parameter Group for Postgres",
                "family": "aurora-postgresql",
                "name": "example-cluster-pg"
            },
            "Blocks": [
                {
                    "Type": "parameter",
                    "Attributes": {
                        "name": "log_statement",
                        "value": "all"
                    }
                }
            ]
        },
        {
            "Type": "resource",
            "Labels": ["aws_rds_cluster", "example"],
            "Attributes": {
                "availability_zones": ["us-east-1a", "us-east-1b"],
                "backup_retention_period": "7",
                "cluster_identifier": "example-cluster",
                "cluster_parameter_group_name": "aws_rds_cluster_parameter_group.example.name",
                "database_name": "exampledb",
                "db_subnet_group_name": "aws_db_subnet_group.example.name",
                "engine": "aurora-postgresql",
                "engine_mode": "provisioned",
                "master_password": "P@ssw0rd123",
                "master_username": "admin",
                "skip_final_snapshot": true,
                "vpc_security_group_ids": "aws_security_group.example.id"
            },
            "Blocks": [],
            "line_range": {"endLine": 30, "startLine": 17}
        }
    ]
	count(result) == 1
}
