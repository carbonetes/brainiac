package lib.terraform.CB_TFAWS_136
import rego.v1

test_aws_workspaces_workspace_encrypted_passed if {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_workspaces_workspace",
                                "pass"
                                ],
                                "Attributes": {
                                "user_volume_encryption_enabled": true,
                                "volume_encryption_key": "var.volume_encryption_key"
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

test_aws_workspaces_workspace_encrypted_failed if {
result := failed with input as [
                               {
                                "Type": "resource",
                                "Labels": [
                                "aws_workspaces_workspace",
                                "pass"
                                ],
                                "Attributes": {
                                "user_volume_encryption_enabled": false,
                                "volume_encryption_key": "var.volume_encryption_key"
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