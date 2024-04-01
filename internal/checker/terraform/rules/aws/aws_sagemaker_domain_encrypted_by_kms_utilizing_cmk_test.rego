package lib.terraform.CB_TFAWS_178
import rego.v1

test_aws_sagemaker_domain_encrypted_by_kms_utilizing_cmk_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_sagemaker_domain",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "auth_mode": "IAM",
                                    "domain_name": "example",
                                    "kms_key_id": "kms",
                                    "subnet_ids": "aws_subnet.test.id",
                                    "vpc_id": "aws_vpc.test.id"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "default_user_settings",
                                        "Labels": [],
                                        "Attributes": {
                                        "execution_role": "aws_iam_role.test.arn"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 9,
                                        "startLine": 7
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 10,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_sagemaker_domain_encrypted_by_kms_utilizing_cmk_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_sagemaker_domain",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "auth_mode": "IAM",
                                    "domain_name": "example",
                                    "kms_key_id": "",
                                    "subnet_ids": "aws_subnet.test.id",
                                    "vpc_id": "aws_vpc.test.id"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "default_user_settings",
                                        "Labels": [],
                                        "Attributes": {
                                        "execution_role": "aws_iam_role.test.arn"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 9,
                                        "startLine": 7
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 10,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
