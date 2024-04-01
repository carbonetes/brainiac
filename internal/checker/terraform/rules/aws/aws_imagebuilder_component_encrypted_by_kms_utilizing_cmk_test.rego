package lib.terraform.CB_TFAWS_171
import rego.v1

test_aws_imagebuilder_component_encrypted_by_kms_utilizing_cmk_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_imagebuilder_component",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "kms_key_id": "kms",
                                    "name": "example",
                                    "platform": "Linux",
                                    "version": "1.0.0"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 20,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_imagebuilder_component_encrypted_by_kms_utilizing_cmk_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_imagebuilder_component",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "kms_key_id": "",
                                    "name": "example",
                                    "platform": "Linux",
                                    "version": "1.0.0"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 20,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
