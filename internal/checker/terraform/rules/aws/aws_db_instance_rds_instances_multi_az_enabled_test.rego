package lib.terraform.CB_TFAWS_148
import rego.v1

test_aws_db_instance_rds_instances_multi_az_enabled_passed if {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_db_instance",
                                "default"
                                ],
                                "Attributes": {
                                "multi_az": true,
                                "name": "mydb"
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

test_aws_db_instance_rds_instances_multi_az_enabled_failed if {
result := failed with input as [
                               {
                                "Type": "resource",
                                "Labels": [
                                "aws_db_instance",
                                "default"
                                ],
                                "Attributes": {
                                "multi_az": false,
                                "name": "mydb"
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