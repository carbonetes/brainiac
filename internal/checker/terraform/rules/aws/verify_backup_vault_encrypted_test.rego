package lib.terraform.CB_TFAWS_157
import rego.v1

test_verify_rds_cluster_snapshot_encryption_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_backup_vault",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "kms_key_arn": "arn:aws:kms:us-west-2:123456789012:key/abcd1234-abcd-1234-abcd-1234abcd1234"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 3,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}

test_verify_rds_cluster_snapshot_encryption_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_backup_vault",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "tc": "arn:aws:kms:us-west-2:123456789012:key/abcd1234-abcd-1234-abcd-1234abcd1234"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 3,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}