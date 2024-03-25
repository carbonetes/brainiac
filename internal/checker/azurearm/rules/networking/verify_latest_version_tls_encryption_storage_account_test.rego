package lib.azurearm.CB_AZR_078

test_latest_version_tls_encryption_storage_account_pass {
	result := passed with input as {
    "resources": [
        {
            "type": "Microsoft.Storage/storageAccounts",
            "properties": {
                "minimumTlsVersion": "TLS1_2"
            }
        }
    ]
}
    count(result) == 1
}

test_latest_version_tls_encryption_storage_account_fail {
	result := failed with input as {
    "resources": [
        {
            "type": "Microsoft.Storage/storageAccounts",
            "properties": {
                "minimumTlsVersion": "TLS1_0"
            }
        }
    ]
}
    count(result) == 1
}
