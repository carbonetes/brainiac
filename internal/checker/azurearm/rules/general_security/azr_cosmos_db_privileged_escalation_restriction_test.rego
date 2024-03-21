package lib.azurearm.CB_AZR_072

test_azr_cosmos_db_privileged_escalation_restriction_enabled {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.DocumentDB/databaseAccounts",
                "properties": {
                    "disableKeyBasedMetadataWriteAccess": true
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_cosmos_db_privileged_escalation_restriction_disabled {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.DocumentDB/databaseAccounts",
                "properties": {
                }
            }
        ]
    }
	count(result) == 1
}
