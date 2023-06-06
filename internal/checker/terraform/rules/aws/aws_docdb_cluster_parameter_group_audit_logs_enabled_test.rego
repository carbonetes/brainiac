package lib.terraform.CB_TFAWS_073

test_aws_docdb_cluster_parameter_group_audit_logs_enabled_passed {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_docdb_cluster_parameter_group",
                                    "example"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "parameter",
                                        "Labels": [],
                                        "Attributes": {
                                        "name": "audit_logs",
                                        "value": "enabled"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 7,
                                        "startLine": 4
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 8,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_docdb_cluster_parameter_group_audit_logs_enabled_failed {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_docdb_cluster_parameter_group",
                                    "example"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "parameter",
                                        "Labels": [],
                                        "Attributes": {
                                        "name": "not_audit_logs",
                                        "value": "disabled"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 7,
                                        "startLine": 4
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 8,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
