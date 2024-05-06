package lib.terraform.CB_TFAWS_341

import rego.v1 

test_config_recorder_enabled_passed if {
	result := passed with input as [
    {
        "Attributes": {
            "name": "example",
            "role_arn": "aws_iam_role.r.arn"
        },
        "Blocks": [
            {
                "Attributes": {
                    "include_global_resource_types": true
                },
                "Blocks": [],
                "Labels": [],
                "Type": "recording_group",
                "line_range": {
                    "endLine": 7,
                    "startLine": 5
                }
            }
        ],
        "Labels": [
            "aws_config_configuration_recorder",
            "pass_recorder"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    },
    {
        "Attributes": {
            "is_enabled": true,
            "name": "aws_config_configuration_recorder.pass_recorder.name"
        },
        "Blocks": [],
        "Labels": [
            "aws_config_configuration_recorder_status",
            "pass"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 14,
            "startLine": 11
        }
    }
]
	count(result) == 1
}

test_config_recorder_enabled_failed if {
	result := failed with input as [
    {
        "Attributes": {
            "name": "example",
            "role_arn": "aws_iam_role.r.arn"
        },
        "Blocks": [
            {
                "Attributes": {
                    "include_global_resource_types": false
                },
                "Blocks": [],
                "Labels": [],
                "Type": "recording_group",
                "line_range": {
                    "endLine": 7,
                    "startLine": 5
                }
            }
        ],
        "Labels": [
            "aws_config_configuration_recorder",
            "pass_recorder"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    },
    {
        "Attributes": {
            "is_enabled": false,
            "name": "aws_config_configuration_recorder.pass_recorder.name"
        },
        "Blocks": [],
        "Labels": [
            "aws_config_configuration_recorder_status",
            "pass"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 14,
            "startLine": 11
        }
    }
]
	count(result) == 1
}