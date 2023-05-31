package lib.terraform.CB_TFAWS_025

test_aws_neptune_cluster_encrypted_passed {
    result := passed with input as [
                                {
                                   
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_neptune_cluster",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "cluster_identifier": "example-cluster",
                                    "storage_encrypted": true
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 4,
                                    "startLine": 1
                                    }
                                }
                            ]
    count(result) == 1
}

test_aws_neptune_cluster_encrypted_failed {
result := failed with input as [
                                {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_neptune_cluster",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "cluster_identifier": "example-cluster",
                                    "storage_encrypted": false
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 4,
                                    "startLine": 1
                                    }
                                }
                            ]
    count(result) == 1
}