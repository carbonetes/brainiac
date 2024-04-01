package lib.terraform.CB_TFAWS_192
import rego.v1

test_aws_memorydb_cluster_encrypted_at_rest_utilizing_kms_cmks_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_memorydb_cluster",
                                    "pass"
                                    ],
                                    "Attributes": {
                                    "acl_name": "open-access",
                                    "kms_key_arn": "aws_kms_key.example.arn",
                                    "name": "my-cluster",
                                    "node_type": "db.t4g.small",
                                    "num_shards": "2",
                                    "security_group_ids": "aws_security_group.example.id",
                                    "snapshot_retention_limit": "7",
                                    "subnet_group_name": "aws_memorydb_subnet_group.example.id"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 10,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_memorydb_cluster_encrypted_at_rest_utilizing_kms_cmks_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_memorydb_cluster",
                                    "pass"
                                    ],
                                    "Attributes": {
                                    "acl_name": "open-access",
                                    "kms_key_arn": "",
                                    "name": "my-cluster",
                                    "node_type": "db.t4g.small",
                                    "num_shards": "2",
                                    "security_group_ids": "aws_security_group.example.id",
                                    "snapshot_retention_limit": "7",
                                    "subnet_group_name": "aws_memorydb_subnet_group.example.id"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 10,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
