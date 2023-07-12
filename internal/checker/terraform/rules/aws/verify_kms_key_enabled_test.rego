package lib.terraform.CB_TFAWS_199

test_verify_kms_key_enabled_passed {
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

test_verify_kms_key_enabled_failed {
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