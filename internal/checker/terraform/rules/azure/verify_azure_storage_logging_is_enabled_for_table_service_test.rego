package lib.terraform.CB_TFAZR_237

test_azure_storage_logging_is_enabled_for_table_service_passed {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_resource_group",
            "blobExample_ok"
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
            "blobExample_ok"
        ],
        "Attributes": {
            "location": "azurerm_resource_group.blobExample_ok.location",
            "name": "exampleworkspace",
            "resource_group_name": "azurerm_resource_group.blobExample_ok.name",
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
            "blobExample_ok"
        ],
        "Attributes": {
            "account_replication_type": "LRS",
            "account_tier": "Standard",
            "location": "azurerm_resource_group.blobExample_ok.location",
            "name": "examplestoracc",
            "resource_group_name": "azurerm_resource_group.blobExample_ok.name"
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
            "blobExample_ok"
        ],
        "Attributes": {
            "name": "example-storageinsightconfig",
            "resource_group_name": "azurerm_resource_group.blobExample_ok.name",
            "storage_account_id": "azurerm_storage_account.blobExample_ok.id",
            "storage_account_key": "azurerm_storage_account.blobExample_ok.primary_access_key",
            "table_names": [
                "myexampletable_ok"
            ],
            "workspace_id": "azurerm_log_analytics_workspace.blobExample_ok.id"
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
            "azurerm_storage_table",
            "blobExample_ok"
        ],
        "Attributes": {
            "name": "myexampletable_ok",
            "storage_account_name": "azurerm_storage_account.blobExample_ok.name",
            "storage_container_name": "azurerm_storage_container.blobExample_ok.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 36,
            "startLine": 32
        }
    }
]
	count(result) == 1
}

test_azure_storage_logging_is_enabled_for_table_service_failed {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_resource_group",
            "blobExample_ok"
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
            "blobExample_ok"
        ],
        "Attributes": {
            "location": "azurerm_resource_group.blobExample_ok.location",
            "name": "exampleworkspace",
            "resource_group_name": "azurerm_resource_group.blobExample_ok.name",
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
            "blobExample_ok"
        ],
        "Attributes": {
            "account_replication_type": "LRS",
            "account_tier": "Standard",
            "location": "azurerm_resource_group.blobExample_ok.location",
            "name": "examplestoracc",
            "resource_group_name": "azurerm_resource_group.blobExample_ok.name"
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
            "blobExample_ok"
        ],
        "Attributes": {
            "name": "example-storageinsightconfig",
            "resource_group_name": "azurerm_resource_group.blobExample_ok.name",
            "storage_account_id": "",
            "storage_account_key": "azurerm_storage_account.blobExample_ok.primary_access_key",
            "table_names": [
                "myexampletable_ok"
            ],
            "workspace_id": "azurerm_log_analytics_workspace.blobExample_ok.id"
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
            "azurerm_storage_table",
            "blobExample_ok"
        ],
        "Attributes": {
            "name": "myexampletable_ok",
            "storage_account_name": "",
            "storage_container_name": "azurerm_storage_container.blobExample_ok.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 36,
            "startLine": 32
        }
    }
]
	count(result) == 1
}