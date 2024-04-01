package lib.terraform.CB_TFAWS_090
import rego.v1

test_verify_doc_db_logging_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_docdb_cluster",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "enabled_cloudwatch_logs_exports": [
                                        "audit",
                                        "profiler"
                                    ]
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 6,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}

test_verify_doc_db_logging_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_docdb_cluster",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "enabled_cloudwatch_logs_exports": [
                                        "tc"
                                    ]
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 6,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}