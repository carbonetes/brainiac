package lib.terraform.CB_TFAWS_199
import rego.v1

test_verify_kms_key_enabled_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_kms_key",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "is_enabled": true
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

test_verify_kms_key_enabled_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_kms_key",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "is_enabled": false
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