package lib.terraform.CB_TFAWS_132

test_aws_lb_cross_zone_load_balancing_enabled_passed {
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

test_aws_lb_cross_zone_load_balancing_enabled_failed {
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