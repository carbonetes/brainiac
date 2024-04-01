package lib.terraform.CB_TFAWS_133
import rego.v1

test_aws_default_vpc_not_allowed_passed if {
result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "aws_default_vpc",
            "default"
        ],
        "Attributes": {
            "tags": {
                "Name": "Default VPC"
            }
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }
]
    count(result) == 1
}

test_aws_default_vpc_not_allowed_failed if {
result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "aws_default_vpc",
            "default"
        ],
        "Attributes": {
            "tags": {
                "Name": "PlaceholderVpc"
            }
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }
]
    count(result) == 1
}
