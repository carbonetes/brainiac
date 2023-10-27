package lib.terraform.CB_TFAZR_238

test_azure_storage_logging_is_enabled_for_blob_service_passed {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_resource_group",
            "resource_group_ok"
        ],
        "Attributes": {
            "location": "West Europe",
            "name": "example-resources"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_log_analytics_workspace",
            "analytics_workspace_ok"
        ],
        "Attributes": {
            "location": "azurerm_resource_group.resource_group_ok.location",
            "name": "exampleworkspace",
            "resource_group_name": "azurerm_resource_group.resource_group_ok.name",
            "retention_in_days": "30",
            "sku": "PerGB2018"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 6
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_storage_account",
            "storage_account_ok"
        ],
        "Attributes": {
            "account_replication_type": "LRS",
            "account_tier": "Standard",
            "location": "azurerm_resource_group.resource_group_ok.location",
            "name": "examplestoracc",
            "resource_group_name": "azurerm_resource_group.resource_group_ok.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 20,
            "startLine": 14
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_log_analytics_storage_insights",
            "analytics_storage_insights_ok"
        ],
        "Attributes": {
            "blob_container_names": [
                "blobExample_ok"
            ],
            "name": "example-storageinsightconfig",
            "resource_group_name": "azurerm_resource_group.resource_group_ok.name",
            "storage_account_id": "azurerm_storage_account.storage_account_ok.id",
            "storage_account_key": "azurerm_storage_account.storage_account_ok.primary_access_key",
            "workspace_id": "azurerm_log_analytics_workspace.analytics_workspace_ok.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 30,
            "startLine": 22
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_storage_container",
            "storage_container_ok"
        ],
        "Attributes": {
            "container_access_type": "blob",
            "name": "my-awesome-content.zip",
            "storage_account_name": "azurerm_storage_account.storage_account_ok.name",
            "storage_container_name": "azurerm_storage_container.storage_container_ok.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 37,
            "startLine": 32
        }
    }
]
	count(result) == 1
}

test_azure_storage_logging_is_enabled_for_blob_service_failed {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_resource_group",
            "resource_group_ok"
        ],
        "Attributes": {
            "location": "West Europe",
            "name": "example-resources"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_log_analytics_workspace",
            "analytics_workspace_ok"
        ],
        "Attributes": {
            "location": "azurerm_resource_group.resource_group_ok.location",
            "name": "exampleworkspace",
            "resource_group_name": "azurerm_resource_group.resource_group_ok.name",
            "retention_in_days": "30",
            "sku": "PerGB2018"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 6
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_storage_account",
            "storage_account_ok"
        ],
        "Attributes": {
            "account_replication_type": "LRS",
            "account_tier": "Standard",
            "location": "azurerm_resource_group.resource_group_ok.location",
            "name": "examplestoracc",
            "resource_group_name": "azurerm_resource_group.resource_group_ok.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 20,
            "startLine": 14
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_log_analytics_storage_insights",
            "analytics_storage_insights_ok"
        ],
        "Attributes": {
            "blob_container_names": [
                "blobExample_ok"
            ],
            "name": "example-storageinsightconfig",
            "resource_group_name": "azurerm_resource_group.resource_group_ok.name",
            "storage_account_id": "",
            "storage_account_key": "azurerm_storage_account.storage_account_ok.primary_access_key",
            "workspace_id": "azurerm_log_analytics_workspace.analytics_workspace_ok.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 30,
            "startLine": 22
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_storage_container",
            "storage_container_ok"
        ],
        "Attributes": {
            "container_access_type": "",
            "name": "my-awesome-content.zip",
            "storage_account_name": "",
            "storage_container_name": "azurerm_storage_container.storage_container_ok.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 37,
            "startLine": 32
        }
    }
]
	count(result) == 1
}