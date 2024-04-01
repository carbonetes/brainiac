package lib.terraform.CB_TFAWS_054
import rego.v1

test_aws_harcode_secrets_passed if {
    result := passed with input as [
                                {
                                "Type": "provider",
                                "Labels": [
                                "aws"
                                ],
                                "Attributes": {
                                "access_key": "NOTEXACTLYAKEY",
                                "region": "var.region",
                                "secret_key": "NOTACTUALLYASECRET"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 5,
                                "startLine": 1
                                }
                                }
                                ]
    count(result) == 1
}

test_aws_no_harcode_secrets_passed if {
    result := failed with input as [
                                {
                                "Type": "provider",
                                "Labels": [
                                "aws"
                                ],
                                "Attributes": {
                                "access_key": "AKIAIOSFODNN7EXAMPLE",
                                "region": "var.region",
                                "secret_key": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 5,
                                "startLine": 1
                                }
                                }
                                ]
    count(result) == 1
}