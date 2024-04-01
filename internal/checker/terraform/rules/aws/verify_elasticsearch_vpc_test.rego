package lib.terraform.CB_TFAWS_140
import rego.v1

test_verify_elasticsearch_vpc_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_elasticsearch_domain",
                                    "elasticsearch_domain"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "vpc_options",
                                        "Labels": [],
                                        "Attributes": {
                                        "security_group_ids": "aws_security_group.elasticsearch_sg.id",
                                        "subnet_ids": "aws_subnet.elasticsearch_subnet.id"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 5,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 6,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}

test_verify_elasticsearch_vpc_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_elasticsearch_domain",
                                    "elasticsearch_domain"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "tc",
                                        "Labels": [],
                                        "Attributes": {
                                        "security_group_ids": "aws_security_group.elasticsearch_sg.id",
                                        "subnet_ids": "aws_subnet.elasticsearch_subnet.id"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 5,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 6,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}