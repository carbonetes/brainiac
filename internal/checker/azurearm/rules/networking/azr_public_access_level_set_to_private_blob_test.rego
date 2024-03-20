package lib.azurearm.CB_AZR_034

test_azr_public_access_level_set_to_private_blob_enabled {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.Storage/storageAccounts/blobServices/containers",
                "name": "default",
                "properties": {
                    "publicAccess": "Private"
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_public_access_level_set_to_private_blob_not_enabled {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.Storage/storageAccounts/blobServices/containers",
                "name": "default",
                "properties": {
                    "publicAccess": "blob"
                }
            }
        ]
    }
	count(result) == 1
}