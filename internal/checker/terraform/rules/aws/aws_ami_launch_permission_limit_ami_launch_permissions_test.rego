package lib.terraform.CB_TFAWS_204
import rego.v1

test_aws_ami_launch_permission_limit_ami_launch_permissions_passed if {
    result := passed with input as [
                        {
                            "Type": "resource",
                            "Labels": [
                                "aws_ami_launch_permission",
                                "remove_equivalent_block"
                            ],
                            "Attributes": {
                                "account_id": "987654321",
                                "image_id": "ami-2345678"
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

test_aws_ami_launch_permission_limit_ami_launch_permissions_failed if {
    result := failed with input as [
                        {
                            "Type": "resource",
                            "Labels": [
                                "aws_ami_launch_permission",
                                "remove_equivalent_block"
                            ],
                            "Attributes": {
                                "account_id": "",
                                "image_id": ""
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