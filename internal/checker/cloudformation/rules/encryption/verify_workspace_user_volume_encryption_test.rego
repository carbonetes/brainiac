package lib.cloudformation.CB_CFT_095

test_workspace_user_volume_encrypted {
	result := passed with input as {
		"Resources": {
			"MyWorkspace": {
				"Type": "AWS::WorkSpaces::Workspace",
				"Properties": {
					"UserVolumeEncryptionEnabled": true
				}
			}
		}
	}
	count(result) == 1
}

test_workspace_user_volume_not_encrypted {
	result := failed with input as {
		"Resources": {
			"MyWorkspace": {
				"Type": "AWS::WorkSpaces::Workspace",
				"Properties": {
					"UserVolumeEncryptionEnabled": false
				}
			}
		}
	}
	count(result) == 1
}
