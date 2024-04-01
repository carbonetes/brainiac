package lib.terraform.CB_TFAWS_180
import rego.v1

test_aws_ebs_volume_encrypted_by_kms_utilizing_cmk_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ebs_volume",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "availability_zone": "us-west-2a",
                                    "kms_key_id": "kms",
                                    "size": "40",
                                    "tags": {
                                        "Name": "HelloWorld"
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

test_aws_ebs_volume_encrypted_by_kms_utilizing_cmk_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ebs_volume",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "availability_zone": "us-west-2a",
                                    "kms_key_id": "",
                                    "size": "40",
                                    "tags": {
                                        "Name": "HelloWorld"
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
