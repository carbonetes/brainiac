package lib.terraform.CB_TFAWS_299

import rego.v1

test_rds_cluster_encrypted_with_cmk_passed if {
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
            "aws_kms_key",
            "rds_encryption_key"
        ],
        "Attributes": {
            "description": "KMS key for RDS encryption"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 5
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_rds_cluster",
            "encrypted_cluster"
        ],
        "Attributes": {
            "allocated_storage": "100",
            "cluster_identifier": "my-encrypted-cluster",
            "database_name": "mydatabase",
            "db_subnet_group_name": "my-db-subnet-group",
            "engine": "aurora",
            "engine_version": "5.7.mysql_aurora.2.08.1",
            "instance_class": "db.r5.large",
            "kms_key_id": "aws_kms_key.rds_encryption_key.arn",
            "master_password": "db_password",
            "master_username": "db_user",
            "tags": {
                "Name": "My Encrypted Aurora Cluster"
            },
            "vpc_security_group_ids": [
                "sg-xxxxxxxxxxxxxxxxx"
            ]
        },
        "Blocks": [],
        "line_range": {
            "endLine": 41,
            "startLine": 10
        }
    }
]
	count(result) == 1
}

test_rds_cluster_encrypted_with_cmk_failed if {
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
            "aws_kms_key",
            "rds_encryption_key"
        ],
        "Attributes": {
            "description": "KMS key for RDS encryption"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 5
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_rds_cluster",
            "encrypted_cluster"
        ],
        "Attributes": {
            "allocated_storage": "100",
            "cluster_identifier": "my-encrypted-cluster",
            "database_name": "mydatabase",
            "db_subnet_group_name": "my-db-subnet-group",
            "engine": "aurora",
            "engine_version": "5.7.mysql_aurora.2.08.1",
            "instance_class": "db.r5.large",
            "kms_key_id": "",
            "master_password": "db_password",
            "master_username": "db_user",
            "tags": {
                "Name": "My Encrypted Aurora Cluster"
            },
            "vpc_security_group_ids": [
                "sg-xxxxxxxxxxxxxxxxx"
            ]
        },
        "Blocks": [],
        "line_range": {
            "endLine": 41,
            "startLine": 10
        }
    }
]
	count(result) == 1
}
