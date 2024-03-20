package lib.azurearm.CB_AZR_057

test_infrastructure_encryption_enabled_pass {
	result := passed with input as {
        "resources": [
            {
          "type": "Microsoft.DBforMySQL/flexibleServers",
          "properties": {
                "dataEncryption": {
                  "geoBackupKeyURI": "string",
                  "geoBackupUserAssignedIdentityId": "string",
                  "primaryKeyURI": "string",
                  "primaryUserAssignedIdentityId": "string",
                  "type": "string"
                }
                }
            }
        ]
    }
	count(result) == 1
}

test_infrastructure_encryption_disabled_fail {
	result := failed with input as {
        "resources": [
            {
          "type": "Microsoft.DBforMySQL/flexibleServers",
          "properties": {
                "dataEncryption": {}
                }
            }
        ]
    }
	count(result) == 1
}
