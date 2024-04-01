package lib.terraform.CB_TFAWS_132
import rego.v1

test_aws_lb_cross_zone_load_balancing_enabled_passed if {
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_lb",
                        "example_lb"
                        ],
                        "Attributes": {
                        "enable_cross_zone_load_balancing": true,
                        "load_balancer_type": "network",
                        "name": "example-lb"
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 7,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}

test_aws_lb_cross_zone_load_balancing_enabled_failed if {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_lb",
                        "example_lb"
                        ],
                        "Attributes": {
                        "enable_cross_zone_load_balancing": false,
                        "load_balancer_type": "network",
                        "name": "example-lb"
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 7,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}