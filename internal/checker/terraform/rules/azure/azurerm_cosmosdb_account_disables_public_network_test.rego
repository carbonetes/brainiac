package lib.terraform.CB_TFAZR_089

test_azurerm_cosmosdb_account_passed {
    result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "example-resource-group"
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
                "random_integer",
                "ri"
            ],
            "Attributes": {
                "max": "99999",
                "min": "10000"
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
                "azurerm_cosmosdb_account",
                "db"
            ],
            "Attributes": {
                "enable_automatic_failover": true,
                "kind": "MongoDB",
                "location": "azurerm_resource_group.example.location",
                "name": "random_integer.ri.result",
                "offer_type": "Standard",
                "public_network_access_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "capabilities",
                    "Labels": [],
                    "Attributes": {
                        "name": "EnableAggregationPipeline"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 24,
                        "startLine": 22
                    }
                },
                {
                    "Type": "capabilities",
                    "Labels": [],
                    "Attributes": {
                        "name": "mongoEnableDocLevelTTL"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 28,
                        "startLine": 26
                    }
                },
                {
                    "Type": "capabilities",
                    "Labels": [],
                    "Attributes": {
                        "name": "MongoDBv3.4"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 32,
                        "startLine": 30
                    }
                },
                {
                    "Type": "capabilities",
                    "Labels": [],
                    "Attributes": {
                        "name": "EnableMongo"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 36,
                        "startLine": 34
                    }
                },
                {
                    "Type": "consistency_policy",
                    "Labels": [],
                    "Attributes": {
                        "consistency_level": "BoundedStaleness",
                        "max_interval_in_seconds": "300",
                        "max_staleness_prefix": "100000"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 42,
                        "startLine": 38
                    }
                },
                {
                    "Type": "geo_location",
                    "Labels": [],
                    "Attributes": {
                        "failover_priority": "1",
                        "location": "eastus"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 47,
                        "startLine": 44
                    }
                },
                {
                    "Type": "geo_location",
                    "Labels": [],
                    "Attributes": {
                        "failover_priority": "0",
                        "location": "westus"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 52,
                        "startLine": 49
                    }
                }
            ],
            "line_range": {
                "endLine": 53,
                "startLine": 11
            }
        }
    ]

    count(result) == 1
}

test_azurerm_cosmosdb_account_failed {
result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "example-resource-group"
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
                "random_integer",
                "ri"
            ],
            "Attributes": {
                "max": "99999",
                "min": "10000"
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
                "azurerm_cosmosdb_account",
                "db"
            ],
            "Attributes": {
                "enable_automatic_failover": true,
                "kind": "MongoDB",
                "location": "azurerm_resource_group.example.location",
                "name": "random_integer.ri.result",
                "offer_type": "Standard",
                "public_network_access_enabled": true,
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "capabilities",
                    "Labels": [],
                    "Attributes": {
                        "name": "EnableAggregationPipeline"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 24,
                        "startLine": 22
                    }
                },
                {
                    "Type": "capabilities",
                    "Labels": [],
                    "Attributes": {
                        "name": "mongoEnableDocLevelTTL"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 28,
                        "startLine": 26
                    }
                },
                {
                    "Type": "capabilities",
                    "Labels": [],
                    "Attributes": {
                        "name": "MongoDBv3.4"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 32,
                        "startLine": 30
                    }
                },
                {
                    "Type": "capabilities",
                    "Labels": [],
                    "Attributes": {
                        "name": "EnableMongo"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 36,
                        "startLine": 34
                    }
                },
                {
                    "Type": "consistency_policy",
                    "Labels": [],
                    "Attributes": {
                        "consistency_level": "BoundedStaleness",
                        "max_interval_in_seconds": "300",
                        "max_staleness_prefix": "100000"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 42,
                        "startLine": 38
                    }
                },
                {
                    "Type": "geo_location",
                    "Labels": [],
                    "Attributes": {
                        "failover_priority": "1",
                        "location": "eastus"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 47,
                        "startLine": 44
                    }
                },
                {
                    "Type": "geo_location",
                    "Labels": [],
                    "Attributes": {
                        "failover_priority": "0",
                        "location": "westus"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 52,
                        "startLine": 49
                    }
                }
            ],
            "line_range": {
                "endLine": 53,
                "startLine": 11
            }
        }
    ]

    count(result) == 1
}
