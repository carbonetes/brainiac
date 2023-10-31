package lib.terraform.CB_TFAZR_161

test_azurerm_function_app_tls_latest_version_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_function_app",
			"pass2",
		],
		"Attributes": {
			"app_service_plan_id": "azurerm_app_service_plan.example.id",
			"https_only": false,
			"location": "azurerm_resource_group.example.location",
			"name": "test-azure-functions",
			"resource_group_name": "azurerm_resource_group.example.name",
			"storage_account_access_key": "azurerm_storage_account.example.primary_access_key",
			"storage_account_name": "azurerm_storage_account.example.name",
		},
		"Blocks": [{
			"Type": "site_config",
			"Labels": [],
			"Attributes": {
				"dotnet_framework_version": "v4.0",
				"ftps_state": "AllAllowed",
				"http2_enabled": false,
				"min_tls_version": "1.2",
				"scm_type": "LocalGit",
			},
			"Blocks": [{
				"Type": "cors",
				"Labels": [],
				"Attributes": {"allowed_origins": ["*"]},
				"Blocks": [],
				"line_range": {
					"endLine": 18,
					"startLine": 16,
				},
			}],
			"line_range": {
				"endLine": 19,
				"startLine": 10,
			},
		}],
		"line_range": {
			"endLine": 20,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_azurerm_function_app_tls_latest_version_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_function_app",
			"pass2",
		],
		"Attributes": {
			"app_service_plan_id": "azurerm_app_service_plan.example.id",
			"https_only": false,
			"location": "azurerm_resource_group.example.location",
			"name": "test-azure-functions",
			"resource_group_name": "azurerm_resource_group.example.name",
			"storage_account_access_key": "azurerm_storage_account.example.primary_access_key",
			"storage_account_name": "azurerm_storage_account.example.name",
		},
		"Blocks": [{
			"Type": "site_config",
			"Labels": [],
			"Attributes": {
				"dotnet_framework_version": "v4.0",
				"ftps_state": "AllAllowed",
				"http2_enabled": false,
				"min_tls_version": "1.3",
				"scm_type": "LocalGit",
			},
			"Blocks": [{
				"Type": "cors",
				"Labels": [],
				"Attributes": {"allowed_origins": ["*"]},
				"Blocks": [],
				"line_range": {
					"endLine": 18,
					"startLine": 16,
				},
			}],
			"line_range": {
				"endLine": 19,
				"startLine": 10,
			},
		}],
		"line_range": {
			"endLine": 20,
			"startLine": 1,
		},
	}]

	count(result) == 1
}
