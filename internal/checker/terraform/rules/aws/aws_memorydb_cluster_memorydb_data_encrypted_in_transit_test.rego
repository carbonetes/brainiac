package lib.terraform.CB_TFAWS_193
import rego.v1

test_aws_memorydb_cluster_memorydb_data_encrypted_in_transit_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_memorydb_cluster",
                                    "pass2"
                                    ],
                                    "Attributes": {
                                    "acl_name": "open-access",
                                    "name": "my-cluster",
                                    "node_type": "db.t4g.small",
                                    "num_shards": "2",
                                    "security_group_ids": "aws_security_group.example.id",
                                    "snapshot_retention_limit": "7",
                                    "subnet_group_name": "aws_memorydb_subnet_group.example.id",
                                    "tls_enabled": true
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

test_aws_memorydb_cluster_memorydb_data_encrypted_in_transit_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_memorydb_cluster",
                                    "pass2"
                                    ],
                                    "Attributes": {
                                    "acl_name": "open-access",
                                    "name": "my-cluster",
                                    "node_type": "db.t4g.small",
                                    "num_shards": "2",
                                    "security_group_ids": "aws_security_group.example.id",
                                    "snapshot_retention_limit": "7",
                                    "subnet_group_name": "aws_memorydb_subnet_group.example.id",
                                    "tls_enabled": false
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
