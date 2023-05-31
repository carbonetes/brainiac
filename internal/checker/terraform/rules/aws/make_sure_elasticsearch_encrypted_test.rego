package lib.terraform.CB_TFAWS_004

test_elasticsearch_encrypted{
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
                            "Type": "encrypt_at_rest",
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

test_elasticsearch_not_encrypted {
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
                            "Type": "encrypt_at_rest",
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