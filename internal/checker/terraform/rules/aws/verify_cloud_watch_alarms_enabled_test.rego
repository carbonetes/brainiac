package lib.terraform.CB_TFAWS_307

import rego.v1 

test_verify_cloud_watch_alarms_enabled_passed if {
    result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_cloudwatch_metric_alarm",
                "example_alarm"
            ],
            "Attributes": {
                "actions_enabled": true
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

test_verify_cloud_watch_alarms_enabled_failed if {
    result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_cloudwatch_metric_alarm",
                "example_alarm"
            ],
            "Attributes": {
                "actions_enabled": false
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