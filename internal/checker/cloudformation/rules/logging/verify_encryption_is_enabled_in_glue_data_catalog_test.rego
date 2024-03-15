package lib.cloudformation.CB_CFT_069

test_glue_data_catalog_encryption_enabled {
	result := passed with input as {"Resources": {"GlueDataCatalogEncryptionSettings": {
		"Properties": {"DataCatalogEncryptionSettings": {
			"ConnectionPasswordEncryption": {"ReturnConnectionPasswordEncrypted": true},
			"EncryptionAtRest": {"CatalogEncryptionMode": "ENABLED"},
		}},
		"Type": "AWS::Glue::DataCatalogEncryptionSettings",
	}}}
	count(result) == 1
}

test_glue_data_catalog_encryption_disabled {
	result := failed with input as {"Resources": {"GlueDataCatalogEncryptionSettings": {
		"Properties": {"DataCatalogEncryptionSettings": {
			"ConnectionPasswordEncryption": {"ReturnConnectionPasswordEncrypted": false},
			"EncryptionAtRest": {"CatalogEncryptionMode": "DISABLED"},
		}},
		"Type": "AWS::Glue::DataCatalogEncryptionSettings",
	}}}
	count(result) == 1
}
