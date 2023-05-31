package lib.terraform.CB_TFAWS_006

enable_key_rotation{
    result := passed with input as [
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_kms_key",
                            "example"
                            ],
                            "Attributes": {
                            "deletion_window_in_days": "30",
                            "description": "Example key for testing",
                            "enable_key_rotation": true
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 50,
                            "startLine": 1
                            }
                            }
                            ]
    count(result) == 1
}

key_rotation_not_secured {
    result := failed with input as [
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_kms_key",
                            "example"
                            ],
                            "Attributes": {
                            "deletion_window_in_days": "30",
                            "description": "Example key for testing",
                            "enable_key_rotation": false
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 50,
                            "startLine": 1
                            }
                            }
                            ]
    count(result) == 1
}