package lib.terraform.CB_TFAWS_300

import rego.v1 

test_alb_desync_mode_passed if {
	result := passed with input as [
    {
        "Type": "provider",
        "Labels": [
            "aws"
        ],
        "Attributes": {
            "region": "us-west-2"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_vpc",
            "example"
        ],
        "Attributes": {
            "cidr_block": "10.0.0.0/16"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 5
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_subnet",
            "example"
        ],
        "Attributes": {
            "cidr_block": "10.0.1.0/24",
            "vpc_id": "aws_vpc.example.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 9
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_security_group",
            "example"
        ],
        "Attributes": {
            "name_prefix": "example-",
            "vpc_id": "aws_vpc.example.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 14
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_alb",
            "example"
        ],
        "Attributes": {
            "internal": false,
            "load_balancer_type": "application",
            "name": "example-alb",
            "routing_http_desync_mitigation_mode": "strictest",
            "security_groups": "aws_security_group.example.id",
            "subnets": "aws_subnet.example.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 30,
            "startLine": 19
        }
    }
]
	count(result) == 1
}

test_alb_desync_mode_failed if {
	result := failed with input as [
    {
        "Type": "provider",
        "Labels": [
            "aws"
        ],
        "Attributes": {
            "region": "us-west-2"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_vpc",
            "example"
        ],
        "Attributes": {
            "cidr_block": "10.0.0.0/16"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 5
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_subnet",
            "example"
        ],
        "Attributes": {
            "cidr_block": "10.0.1.0/24",
            "vpc_id": "aws_vpc.example.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 9
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_security_group",
            "example"
        ],
        "Attributes": {
            "name_prefix": "example-",
            "vpc_id": "aws_vpc.example.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 14
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_alb",
            "example"
        ],
        "Attributes": {
            "internal": false,
            "load_balancer_type": "application",
            "name": "example-alb",
            "routing_http_desync_mitigation_mode": "monitor",
            "security_groups": "aws_security_group.example.id",
            "subnets": "aws_subnet.example.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 30,
            "startLine": 19
        }
    }
]
	count(result) == 1
}
