package lib.terraform.CB_TFAWS_141
import rego.v1

test_verify_elb_cross_zone_enabled_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_elb",
                                    "example_elb"
                                    ],
                                    "Attributes": {
                                    "cross_zone_load_balancing": true
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

test_verify_elb_cross_zone_enabled_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_elb",
                                    "example_elb"
                                    ],
                                    "Attributes": {
                                    "cross_zone_load_balancing": false
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