package lib.terraform.CB_TFAWS_097
import rego.v1

test_enable_doc_db_tls_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_docdb_cluster_parameter_group",
                                    "tls_parameter_group"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "parameter",
                                        "Labels": [],
                                        "Attributes": {
                                        "name": "tls",
                                        "value": "enabled"
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

test_enable_doc_db_tls_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_docdb_cluster_parameter_group",
                                    "tls_parameter_group"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "parameter",
                                        "Labels": [],
                                        "Attributes": {
                                        "name": "tls",
                                        "value": "disabled"
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