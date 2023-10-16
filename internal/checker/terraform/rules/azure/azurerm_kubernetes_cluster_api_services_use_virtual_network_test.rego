package lib.terraform.CB_TFAZR_117

test_azurerm_kubernetes_cluster_api_services_use_virtual_network_passed {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "example"
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
                "azurerm_private_dns_zone",
                "example"
            ],
            "Attributes": {
                "name": "privatelink.eastus2.azmk8s.io",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 9,
                "startLine": 6
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_user_assigned_identity",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "aks-example-identity",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 15,
                "startLine": 11
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_role_assignment",
                "example"
            ],
            "Attributes": {
                "principal_id": "azurerm_user_assigned_identity.example.principal_id",
                "role_definition_name": "Private DNS Zone Contributor",
                "scope": "azurerm_private_dns_zone.example.id"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 21,
                "startLine": 17
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_kubernetes_cluster",
                "example"
            ],
            "Attributes": {
                "depends_on": "azurerm_role_assignment.example",
                "dns_prefix": "aksexamplednsprefix1",
                "location": "azurerm_resource_group.example.location",
                "name": "aksexamplewithprivatednszone1",
                "private_cluster_enabled": true,
                "private_dns_zone_id": "azurerm_private_dns_zone.example.id",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 36,
                "startLine": 23
            }
        }
    ]
	count(result) == 1
}

test_azurerm_kubernetes_cluster_api_services_use_virtual_network_failed {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "example"
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
                "azurerm_private_dns_zone",
                "example"
            ],
            "Attributes": {
                "name": "privatelink.eastus2.azmk8s.io",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 9,
                "startLine": 6
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_user_assigned_identity",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "aks-example-identity",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 15,
                "startLine": 11
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_role_assignment",
                "example"
            ],
            "Attributes": {
                "principal_id": "azurerm_user_assigned_identity.example.principal_id",
                "role_definition_name": "Private DNS Zone Contributor",
                "scope": "azurerm_private_dns_zone.example.id"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 21,
                "startLine": 17
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_kubernetes_cluster",
                "example"
            ],
            "Attributes": {
                "depends_on": "azurerm_role_assignment.example",
                "dns_prefix": "aksexamplednsprefix1",
                "location": "azurerm_resource_group.example.location",
                "name": "aksexamplewithprivatednszone1",
                "private_cluster_enabled": false,
                "private_dns_zone_id": "azurerm_private_dns_zone.example.id",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 36,
                "startLine": 23
            }
        }
    ]
	count(result) == 1
}