package lib.terraform.CB_TFAWS_005

test_elasticsearch_node_enabled{
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_elasticsearch_domain",
                        "example"
                        ],
                        "Attributes": {
                        "domain_name": "example-domain",
                        "elasticsearch_version": "7.10"
                        },
                        "Blocks": [
                        {
                            "Type": "node_to_node_encryption_options",
                            "Labels": [],
                            "Attributes": {
                            "enabled": true
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 75,
                            "startLine": 73
                            }
                        }
                        ],
                        "line_range": {
                        "endLine": 78,
                        "startLine": 69
                        }
                        }
                        ]
    count(result) == 1
}

test_elasticsearch_node_disabled{
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_elasticsearch_domain",
                        "example"
                        ],
                        "Attributes": {
                        "domain_name": "example-domain",
                        "elasticsearch_version": "7.10"
                        },
                        "Blocks": [
                        {
                            "Type": "node_to_node_encryption_options",
                            "Labels": [],
                            "Attributes": {
                            "enabled": false
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 75,
                            "startLine": 73
                            }
                        }
                        ],
                        "line_range": {
                        "endLine": 78,
                        "startLine": 69
                        }
                        }
                        ]
    count(result) == 1
}