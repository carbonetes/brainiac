package lib.cloudformation.CB_CFT_096

test_workspace_root_volume_encrypted {
	result := passed with input as {
		"Resources": {
			"MyWorkspace": {
				"Type": "AWS::WorkSpaces::Workspace",
				"Properties": {
					"RootVolumeEncryptionEnabled": true
				}
			}
		}
	}
	count(result) == 1
}

test_workspace_root_volume_not_encrypted {
	result := failed with input as {
		"Resources": {
			"MyWorkspace": {
				"Type": "AWS::WorkSpaces::Workspace",
				"Properties": {
					"RootVolumeEncryptionEnabled": false
				}
			}
		}
	}
	count(result) == 1
}
