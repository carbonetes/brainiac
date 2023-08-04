package lib.terraform.CB_TFAWS_302

test_verify_auto_scaling_launch_template_passed {
    result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_codebuild_project",
                "example_project"
            ],
            "Attributes": {},
            "Blocks": [
                {
                    "Type": "environment",
                    "Labels": [],
                    "Attributes": {
                        "privileged_mode": false
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 4,
                        "startLine": 2
                    }
                }
            ],
            "line_range": {
                "endLine": 5,
                "startLine": 1
            }
        }
    ]
    count(result) == 1
}

test_verify_auto_scaling_launch_template_failed {
    result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_codebuild_project",
                "example_project"
            ],
            "Attributes": {},
            "Blocks": [
                {
                    "Type": "environment",
                    "Labels": [],
                    "Attributes": {
                        "privileged_mode": true
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 4,
                        "startLine": 2
                    }
                }
            ],
            "line_range": {
                "endLine": 5,
                "startLine": 1
            }
        }
    ]
    count(result) == 1
}