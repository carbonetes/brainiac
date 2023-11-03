package lib.terraform.CB_TFAZR_234

test_azure_data_factories_encrypted_with_customer_managed_key_passed {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_data_factory",
            "data_factory_good"
        ],
        "Attributes": {
            "location": "location",
            "name": "example",
            "resource_group_name": "group"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_data_factory_linked_service_key_vault",
            "factory_good"
        ],
        "Attributes": {
            "data_factory_name": "azurerm_data_factory.data_factory_good.name",
            "key_vault_id": "123456",
            "name": "example",
            "resource_group_name": "example"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 7
        }
    }
]
	count(result) == 1
}

test_azure_data_factories_encrypted_with_customer_managed_key_failed {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_data_factory",
            "data_factory_good"
        ],
        "Attributes": {
            "location": "location",
            "name": "example",
            "resource_group_name": "group"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_data_factory_linked_service_key_vault",
            "factory_good"
        ],
        "Attributes": {
            "data_factory_name": "",
            "key_vault_id": "123456",
            "name": "example",
            "resource_group_name": "example"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 7
        }
    }
]
	count(result) == 1
}