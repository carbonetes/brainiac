package lib.terraform.CB_TFAWS_156
import rego.v1

test_aws_dynamodb_global_table_point_in_time_recovery_for_global_tables_enabled_passed if {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_dynamodb_global_table",
                                "example"
                                ],
                                "Attributes": {
                                "name": "example-global-table"
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

test_aws_dynamodb_global_table_point_in_time_recovery_for_global_tables_enabled_failed if {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_any",
                                "example"
                                ],
                                "Attributes": {
                                "name": "example-global-table"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 3,
                                "startLine": 1
                                }
                                }
                            ]
    count(result) == 0
}

