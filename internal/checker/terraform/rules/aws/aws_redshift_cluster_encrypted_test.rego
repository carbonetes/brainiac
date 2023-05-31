package lib.terraform.CB_TFAWS_062

test_aws_redshift_cluster_encrypted_passed{
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

test_aws_redshift_cluster_encrypted_failed {
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