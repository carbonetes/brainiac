package lib.terraform.CB_TFAWS_340

import rego.v1 

test_aws_vpc_ensure_vpc_flow_logging_enabled_for_all_vpcs_passed if {
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_flow_log",
                        "example"
                        ],
                        "Attributes": {
                        "iam_role_arn": "arn",
                        "log_destination": "log",
                        "traffic_type": "ALL",
                        "vpc_id": "aws_vpc.ok_vpc.id"
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 6,
                        "startLine": 1
                        }
                        },
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_vpc",
                        "ok_vpc"
                        ],
                        "Attributes": {
                        "cidr_block": "10.0.0.0/16"
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 10,
                        "startLine": 8
                        }
                        }
                        ]
    count(result) == 1
}

test_aws_vpc_ensure_vpc_flow_logging_enabled_for_all_vpcs_failed if {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_flow_log",
                        "example"
                        ],
                        "Attributes": {
                        "iam_role_arn": "arn",
                        "log_destination": "log",
                        "traffic_type": "ALL",
                        "vpc_id": ""
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 6,
                        "startLine": 1
                        }
                        },
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_vpc",
                        "ok_vpc"
                        ],
                        "Attributes": {
                        "cidr_block": "10.0.0.0/16"
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 10,
                        "startLine": 8
                        }
                        }
                        ]
    count(result) == 1
}