package lib.azurearm.CB_AZR_033

test_azr_storage_logging_queue_service_read_write_delete_enabled {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.Storage/storageAccounts/queueServices/providers/diagnosticsettings",
                "properties": {
                    "logs": [
                        {
                            "category": "StorageRead",
                            "enabled": "true"
                        },
                        {
                            "category": "StorageWrite",
                            "enabled": "true"
                        },
                        {
                            "category": "StorageDelete",
                            "enabled": "true"
                        }
                    ]
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_storage_logging_queue_service_read_write_delete_not_enabled {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.Storage/storageAccounts/queueServices/providers/diagnosticsettings",
                "properties": {
                    "logs": [
                        {
                            "category": "StorageRead"
                        },
                        {
                            "category": "StorageWrite",
                        },
                        {
                            "category": "StorageDelete",
                        }
                    ]
                }
            }
        ]
    }
	count(result) == 1
}
