package lib.terraform.CB_TFAWS_094
import rego.v1

test_verify_redshift_cluster_publicly_available_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_redshift_cluster",
                                    "example_cluster"
                                    ],
                                    "Attributes": {
                                    "publicly_accessible": false
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

test_verify_redshift_cluster_publicly_available_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_redshift_cluster",
                                    "example_cluster"
                                    ],
                                    "Attributes": {
                                    "publicly_accessible": true
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