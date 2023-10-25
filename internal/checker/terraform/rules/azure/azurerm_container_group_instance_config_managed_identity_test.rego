package lib.terraform.CB_TFAZR_226

test_azurerm_container_group_instance_config_managed_identity_passed {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
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
                "azurerm_container_group",
                "example"
            ],
            "Attributes": {
                "dns_name_label": "aci-label",
                "ip_address_type": "Public",
                "location": "azurerm_resource_group.example.location",
                "name": "example-continst",
                "os_type": "Linux",
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "environment": "testing"
                }
            },
            "Blocks": [
                {
                    "Type": "container",
                    "Labels": [],
                    "Attributes": {
                        "cpu": "0.5",
                        "image": "mcr.microsoft.com/azuredocs/aci-helloworld:latest",
                        "memory": "1.5",
                        "name": "hello-world"
                    },
                    "Blocks": [
                        {
                            "Type": "ports",
                            "Labels": [],
                            "Attributes": {
                                "port": "443",
                                "protocol": "TCP"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 23,
                                "startLine": 20
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 24,
                        "startLine": 14
                    }
                },
                {
                    "Type": "container",
                    "Labels": [],
                    "Attributes": {
                        "cpu": "0.5",
                        "image": "mcr.microsoft.com/azuredocs/aci-tutorial-sidecar",
                        "memory": "1.5",
                        "name": "sidecar"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 31,
                        "startLine": 26
                    }
                },
                {
                    "Type": "identity",
                    "Labels": [],
                    "Attributes": {
                        "type": "SystemAssigned"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 39,
                        "startLine": 37
                    }
                }
            ],
            "line_range": {
                "endLine": 40,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}

test_azurerm_container_group_instance_config_managed_identity_failed {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
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
                "azurerm_container_group",
                "example"
            ],
            "Attributes": {
                "dns_name_label": "aci-label",
                "ip_address_type": "Public",
                "location": "azurerm_resource_group.example.location",
                "name": "example-continst",
                "os_type": "Linux",
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "environment": "testing"
                }
            },
            "Blocks": [
                {
                    "Type": "container",
                    "Labels": [],
                    "Attributes": {
                        "cpu": "0.5",
                        "image": "mcr.microsoft.com/azuredocs/aci-helloworld:latest",
                        "memory": "1.5",
                        "name": "hello-world"
                    },
                    "Blocks": [
                        {
                            "Type": "ports",
                            "Labels": [],
                            "Attributes": {
                                "port": "443",
                                "protocol": "TCP"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 23,
                                "startLine": 20
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 24,
                        "startLine": 14
                    }
                },
                {
                    "Type": "container",
                    "Labels": [],
                    "Attributes": {
                        "cpu": "0.5",
                        "image": "mcr.microsoft.com/azuredocs/aci-tutorial-sidecar",
                        "memory": "1.5",
                        "name": "sidecar"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 31,
                        "startLine": 26
                    }
                }
            ],
            "line_range": {
                "endLine": 40,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}