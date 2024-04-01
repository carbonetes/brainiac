package lib.terraform.CB_TFAWS_298

import rego.v1

test_rds_cluster_aurora_backtrack_passed if {
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
            "aws_rds_cluster",
            "aurora_cluster"
        ],
        "Attributes": {
            "backtrack_window": "1",
            "backup_retention_period": "7",
            "cluster_identifier": "my-aurora-cluster",
            "database_name": "mydb",
            "engine": "aurora",
            "engine_version": "5.7.mysql_aurora.2.10.0",
            "master_password": "your-master-password",
            "master_username": "admin"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 5
        }
    }
]
	count(result) == 1
}

test_rds_cluster_aurora_backtrack_failed if {
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
            "aws_rds_cluster",
            "aurora_cluster"
        ],
        "Attributes": {
            "backtrack_window": "0",
            "backup_retention_period": "7",
            "cluster_identifier": "my-aurora-cluster",
            "database_name": "mydb",
            "engine": "aurora",
            "engine_version": "5.7.mysql_aurora.2.10.0",
            "master_password": "your-master-password",
            "master_username": "admin"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 5
        }
    }
]
	count(result) == 1
}
