package lib.terraform.CB_TFAWS_082
import rego.v1

test_aws_sagemaker_endpoint_configuration_encrypted_passed if {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_sagemaker_endpoint_configuration",
                                "example"
                                ],
                                "Attributes": {
                                "kms_key_arn": "any"
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

test_aws_sagemaker_endpoint_configuration_encrypted_failed if {
result := failed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_sagemaker_endpoint_configuration",
                                "example"
                                ],
                                "Attributes": {
                                
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