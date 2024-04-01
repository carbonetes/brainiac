package lib.terraform.CB_TFAWS_179
import rego.v1

test_aws_redshift_cluster_encrypted_by_kms_utilizing_cmk_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_redshift_cluster",
                                    "pass"
                                    ],
                                    "Attributes": {
                                    "allow_version_upgrade": false,
                                    "automated_snapshot_retention_period": "0",
                                    "availability_zone": "data.aws_availability_zones.available.names.",
                                    "cluster_identifier": "examplea",
                                    "database_name": "mydb",
                                    "encrypted": true,
                                    "kms_key_id": "aws_kms_key.test.arn",
                                    "master_password": "Mustbe8characters",
                                    "master_username": "foo_test",
                                    "node_type": "dc2.large",
                                    "skip_final_snapshot": true
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_redshift_cluster_encrypted_by_kms_utilizing_cmk_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_redshift_cluster",
                                    "pass"
                                    ],
                                    "Attributes": {
                                    "allow_version_upgrade": false,
                                    "automated_snapshot_retention_period": "0",
                                    "availability_zone": "data.aws_availability_zones.available.names.",
                                    "cluster_identifier": "examplea",
                                    "database_name": "mydb",
                                    "encrypted": true,
                                    "kms_key_id": "",
                                    "master_password": "Mustbe8characters",
                                    "master_username": "foo_test",
                                    "node_type": "dc2.large",
                                    "skip_final_snapshot": true
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
