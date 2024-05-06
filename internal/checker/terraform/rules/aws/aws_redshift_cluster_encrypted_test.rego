package lib.terraform.CB_TFAWS_062
import rego.v1

test_aws_redshift_cluster_encrypted_passed if {
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_redshift_cluster",
                        "example"
                        ],
                        "Attributes": {
                        "encrypted": true
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

test_aws_redshift_cluster_encrypted_failed if {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_redshift_cluster",
                        "example"
                        ],
                        "Attributes": {
                        "encrypted": false
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