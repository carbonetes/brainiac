package lib.terraform.CB_TFAWS_056
import rego.v1

test_aws_eks_cluster_eks_encrypted_passed if {
    result := passed with input as [
                                   {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_eks_cluster",
                                    "my_cluster"
                                    ],
                                    "Attributes": {
                                    "name": "my-eks-cluster",
                                    "role_arn": "aws_iam_role.cluster_role.arn"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "encryption_config",
                                        "Labels": [],
                                        "Attributes": {
                                        "provider": "aws-kms"
                                        },
                                        "Blocks": [
                                        {
                                        "Type": "secrets",
                                        "Labels": [],
                                        "Attributes": {
                                        "enabled": true
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 11,
                                        "startLine": 9
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 12,
                                        "startLine": 6
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_eks_cluster_eks_encrypted_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_eks_cluster",
                                    "my_cluster"
                                    ],
                                    "Attributes": {
                                    "name": "my-eks-cluster",
                                    "role_arn": "aws_iam_role.cluster_role.arn"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "example_config",
                                        "Labels": [],
                                        "Attributes": {
                                        "provider": "aws-kms"
                                        },
                                        "Blocks": [
                                        {
                                        "Type": "secrets",
                                        "Labels": [],
                                        "Attributes": {
                                        "enabled": false
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 11,
                                        "startLine": 9
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 12,
                                        "startLine": 6
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
