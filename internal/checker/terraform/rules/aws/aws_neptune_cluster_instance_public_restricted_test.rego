package lib.terraform.CB_TFAWS_071
import rego.v1

test_aws_neptune_cluster_instance_public_restricted_passed if {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_neptune_cluster_instance",
                                "example"
                                ],
                                "Attributes": {
                                "publicly_accessible": false
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

test_aws_neptune_cluster_instance_public_restricted_failed if {
result := failed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_neptune_cluster_instance",
                                "example"
                                ],
                                "Attributes": {
                                "publicly_accessible": true
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