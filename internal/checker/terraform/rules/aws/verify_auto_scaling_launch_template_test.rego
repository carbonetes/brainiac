package lib.terraform.CB_TFAWS_297

import rego.v1 

test_verify_auto_scaling_launch_template_passed if {
    result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_autoscaling_group",
                "example"
            ],
            "Attributes": {},
            "Blocks": [
                {
                    "Type": "launch_template",
                    "Labels": [],
                    "Attributes": {},
                    "Blocks": [],
                    "line_range": {
                        "endLine": 3,
                        "startLine": 2
                    }
                }
            ],
            "line_range": {
                "endLine": 4,
                "startLine": 1
            }
        }
    ]
    count(result) == 1
}

test_verify_auto_scaling_launch_template_failed if {
    result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_autoscaling_group",
                "example"
            ],
            "Attributes": {},
            "Blocks": [
                {
                    "Type": "tc_template",
                    "Labels": [],
                    "Attributes": {},
                    "Blocks": [],
                    "line_range": {
                        "endLine": 3,
                        "startLine": 2
                    }
                }
            ],
            "line_range": {
                "endLine": 4,
                "startLine": 1
            }
        }
    ]
    count(result) == 1
}