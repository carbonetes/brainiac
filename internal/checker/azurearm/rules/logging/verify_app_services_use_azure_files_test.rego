package lib.azurearm.CB_AZR_052

test_app_services_used_azure_files {
	result := passed with input as {"resources": [{
		"type": "Microsoft.Web/sites/config",
		"properties": {"azureStorageAccounts": {"type": "AzureFiles"}},
	}]}

	count(result) == 1
}

test_app_services_not_used_azure_files {
	result := failed with input as {"resources": [{
		"type": "Microsoft.Web/sites/config",
		"properties": {"azureStorageAccounts": {"type": "NotAzure"}},
	}]}
	count(result) == 1
}
