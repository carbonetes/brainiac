package lib.terraform.CB_TFAWS_154

test_aws_transfer_server_disallow_public_exposure_passed {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_transfer_server",
                                "test"
                                ],
                                "Attributes": {
                                "endpoint_type": "VPC",
                                "protocols": [
                                    "SFTP"
                                ]
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

test_aws_transfer_server_disallow_public_exposure_failed {
result := failed with input as [
                               {
                                "Type": "resource",
                                "Labels": [
                                "aws_transfer_server",
                                "test"
                                ],
                                "Attributes": {
                                "endpoint_type": "PUBLIC",
                                "protocols": [
                                    "SFTP"
                                ]
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