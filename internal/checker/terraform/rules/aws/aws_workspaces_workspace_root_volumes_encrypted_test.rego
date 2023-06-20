package lib.terraform.CB_TFAWS_135

test_aws_workspaces_workspace_root_volumes_encrypted_passed {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_workspaces_workspace",
                                "pass"
                                ],
                                "Attributes": {
                                "root_volume_encryption_enabled": true
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

test_aws_workspaces_workspace_root_volumes_encrypted_failed {
result := failed with input as [
                               {
                                "Type": "resource",
                                "Labels": [
                                "aws_workspaces_workspace",
                                "pass"
                                ],
                                "Attributes": {
                                "root_volume_encryption_enabled": false
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