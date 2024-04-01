package lib.terraform.CB_TFAWS_152
import rego.v1

test_aws_db_instance_rds_database_iam_authentication_enabled_passed if {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_db_instance",
                                "example"
                                ],
                                "Attributes": {
                                "engine": "mysql",
                                "iam_database_authentication_enabled": true
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

test_aws_db_instance_rds_database_iam_authentication_enabled_failed if {
result := failed with input as [
                               {
                                "Type": "resource",
                                "Labels": [
                                "aws_db_instance",
                                "example"
                                ],
                                "Attributes": {
                                "engine": "mysql",
                                "iam_database_authentication_enabled": false
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