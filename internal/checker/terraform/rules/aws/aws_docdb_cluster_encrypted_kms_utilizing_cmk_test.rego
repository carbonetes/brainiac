package lib.terraform.CB_TFAWS_173
import rego.v1

test_aws_docdb_cluster_encrypted_kms_utilizing_cmk_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_docdb_cluster",
                                    "docdb"
                                    ],
                                    "Attributes": {
                                    "backup_retention_period": "5",
                                    "cluster_identifier": "my-docdb-cluster",
                                    "engine": "docdb",
                                    "kms_key_id": "kms",
                                    "master_password": "mustbeeightchars",
                                    "master_username": "foo",
                                    "preferred_backup_window": "07:00-09:00",
                                    "skip_final_snapshot": true
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

test_aws_docdb_cluster_encrypted_kms_utilizing_cmk_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_docdb_cluster",
                                    "docdb"
                                    ],
                                    "Attributes": {
                                    "backup_retention_period": "5",
                                    "cluster_identifier": "my-docdb-cluster",
                                    "engine": "docdb",
                                    "kms_key_id": "",
                                    "master_password": "mustbeeightchars",
                                    "master_username": "foo",
                                    "preferred_backup_window": "07:00-09:00",
                                    "skip_final_snapshot": true
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
