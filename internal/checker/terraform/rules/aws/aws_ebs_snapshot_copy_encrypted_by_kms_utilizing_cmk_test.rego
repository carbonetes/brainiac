package lib.terraform.CB_TFAWS_174
import rego.v1

test_aws_ebs_snapshot_copy_encrypted_by_kms_utilizing_cmk_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ebs_snapshot_copy",
                                    "example_copy"
                                    ],
                                    "Attributes": {
                                    "kms_key_id": "kms",
                                    "source_region": "us-west-2",
                                    "source_snapshot_id": "aws_ebs_snapshot.example_snapshot.id",
                                    "tags": {
                                        "Name": "HelloWorld_copy_snap"
                                    }
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 8,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_ebs_snapshot_copy_encrypted_by_kms_utilizing_cmk_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ebs_snapshot_copy",
                                    "example_copy"
                                    ],
                                    "Attributes": {
                                    "kms_key_id": "",
                                    "source_region": "us-west-2",
                                    "source_snapshot_id": "aws_ebs_snapshot.example_snapshot.id",
                                    "tags": {
                                        "Name": "HelloWorld_copy_snap"
                                    }
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 8,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
