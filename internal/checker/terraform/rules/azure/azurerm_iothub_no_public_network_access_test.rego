package lib.terraform.CB_TFAZR_106

test_azurerm_iothub_no_public_network_access_passed {
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
                "azurerm_storage_account",
                "example"
            ],
            "Attributes": {
                "account_replication_type": "LRS",
                "account_tier": "Standard",
                "location": "azurerm_resource_group.example.location",
                "name": "examplestorage",
                "resource_group_name": "azurerm_resource_group.example.name"
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
                "azurerm_storage_container",
                "example"
            ],
            "Attributes": {
                "container_access_type": "private",
                "name": "examplecontainer",
                "storage_account_name": "azurerm_storage_account.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 18,
                "startLine": 14
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_eventhub_namespace",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-namespace",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "Basic"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 25,
                "startLine": 20
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_eventhub",
                "example"
            ],
            "Attributes": {
                "message_retention": "1",
                "name": "example-eventhub",
                "namespace_name": "azurerm_eventhub_namespace.example.name",
                "partition_count": "2",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 33,
                "startLine": 27
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_eventhub_authorization_rule",
                "example"
            ],
            "Attributes": {
                "eventhub_name": "azurerm_eventhub.example.name",
                "name": "acctest",
                "namespace_name": "azurerm_eventhub_namespace.example.name",
                "resource_group_name": "azurerm_resource_group.example.name",
                "send": true
            },
            "Blocks": [],
            "line_range": {
                "endLine": 41,
                "startLine": 35
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_iothub",
                "example"
            ],
            "Attributes": {
                "local_authentication_enabled": false,
                "location": "azurerm_resource_group.example.location",
                "name": "Example-IoTHub",
                "public_network_access_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "purpose": "testing"
                }
            },
            "Blocks": [
                {
                    "Type": "sku",
                    "Labels": [],
                    "Attributes": {
                        "capacity": "1",
                        "name": "S1"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 53,
                        "startLine": 50
                    }
                },
                {
                    "Type": "endpoint",
                    "Labels": [],
                    "Attributes": {
                        "batch_frequency_in_seconds": "60",
                        "connection_string": "azurerm_storage_account.example.primary_blob_connection_string",
                        "container_name": "azurerm_storage_container.example.name",
                        "encoding": "Avro",
                        "file_name_format": "{iothub}/{partition}_{YYYY}_{MM}_{DD}_{HH}_{mm}",
                        "max_chunk_size_in_bytes": "1.048576e+07",
                        "name": "export",
                        "type": "AzureIotHub.StorageContainer"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 64,
                        "startLine": 55
                    }
                },
                {
                    "Type": "endpoint",
                    "Labels": [],
                    "Attributes": {
                        "connection_string": "azurerm_eventhub_authorization_rule.example.primary_connection_string",
                        "name": "export2",
                        "type": "AzureIotHub.EventHub"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 70,
                        "startLine": 66
                    }
                },
                {
                    "Type": "route",
                    "Labels": [],
                    "Attributes": {
                        "condition": "true",
                        "enabled": true,
                        "endpoint_names": [
                            "export"
                        ],
                        "name": "export",
                        "source": "DeviceMessages"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 78,
                        "startLine": 72
                    }
                },
                {
                    "Type": "route",
                    "Labels": [],
                    "Attributes": {
                        "condition": "true",
                        "enabled": true,
                        "endpoint_names": [
                            "export2"
                        ],
                        "name": "export2",
                        "source": "DeviceMessages"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 86,
                        "startLine": 80
                    }
                },
                {
                    "Type": "enrichment",
                    "Labels": [],
                    "Attributes": {
                        "endpoint_names": [
                            "export",
                            "export2"
                        ],
                        "key": "tenant",
                        "value": "$twin.tags.Tenant"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 92,
                        "startLine": 88
                    }
                },
                {
                    "Type": "cloud_to_device",
                    "Labels": [],
                    "Attributes": {
                        "default_ttl": "PT1H",
                        "max_delivery_count": "30"
                    },
                    "Blocks": [
                        {
                            "Type": "feedback",
                            "Labels": [],
                            "Attributes": {
                                "lock_duration": "PT30S",
                                "max_delivery_count": "15",
                                "time_to_live": "PT1H10M"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 101,
                                "startLine": 97
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 102,
                        "startLine": 94
                    }
                }
            ],
            "line_range": {
                "endLine": 107,
                "startLine": 43
            }
        }
    ]

    count(result) == 1
}

test_azurerm_iothub_no_public_network_access_failed {
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
                "azurerm_storage_account",
                "example"
            ],
            "Attributes": {
                "account_replication_type": "LRS",
                "account_tier": "Standard",
                "location": "azurerm_resource_group.example.location",
                "name": "examplestorage",
                "resource_group_name": "azurerm_resource_group.example.name"
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
                "azurerm_storage_container",
                "example"
            ],
            "Attributes": {
                "container_access_type": "private",
                "name": "examplecontainer",
                "storage_account_name": "azurerm_storage_account.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 18,
                "startLine": 14
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_eventhub_namespace",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-namespace",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "Basic"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 25,
                "startLine": 20
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_eventhub",
                "example"
            ],
            "Attributes": {
                "message_retention": "1",
                "name": "example-eventhub",
                "namespace_name": "azurerm_eventhub_namespace.example.name",
                "partition_count": "2",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 33,
                "startLine": 27
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_eventhub_authorization_rule",
                "example"
            ],
            "Attributes": {
                "eventhub_name": "azurerm_eventhub.example.name",
                "name": "acctest",
                "namespace_name": "azurerm_eventhub_namespace.example.name",
                "resource_group_name": "azurerm_resource_group.example.name",
                "send": true
            },
            "Blocks": [],
            "line_range": {
                "endLine": 41,
                "startLine": 35
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_iothub",
                "example"
            ],
            "Attributes": {
                "local_authentication_enabled": false,
                "location": "azurerm_resource_group.example.location",
                "name": "Example-IoTHub",
                "public_network_access_enabled": true,
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "purpose": "testing"
                }
            },
            "Blocks": [
                {
                    "Type": "sku",
                    "Labels": [],
                    "Attributes": {
                        "capacity": "1",
                        "name": "S1"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 53,
                        "startLine": 50
                    }
                },
                {
                    "Type": "endpoint",
                    "Labels": [],
                    "Attributes": {
                        "batch_frequency_in_seconds": "60",
                        "connection_string": "azurerm_storage_account.example.primary_blob_connection_string",
                        "container_name": "azurerm_storage_container.example.name",
                        "encoding": "Avro",
                        "file_name_format": "{iothub}/{partition}_{YYYY}_{MM}_{DD}_{HH}_{mm}",
                        "max_chunk_size_in_bytes": "1.048576e+07",
                        "name": "export",
                        "type": "AzureIotHub.StorageContainer"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 64,
                        "startLine": 55
                    }
                },
                {
                    "Type": "endpoint",
                    "Labels": [],
                    "Attributes": {
                        "connection_string": "azurerm_eventhub_authorization_rule.example.primary_connection_string",
                        "name": "export2",
                        "type": "AzureIotHub.EventHub"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 70,
                        "startLine": 66
                    }
                },
                {
                    "Type": "route",
                    "Labels": [],
                    "Attributes": {
                        "condition": "true",
                        "enabled": true,
                        "endpoint_names": [
                            "export"
                        ],
                        "name": "export",
                        "source": "DeviceMessages"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 78,
                        "startLine": 72
                    }
                },
                {
                    "Type": "route",
                    "Labels": [],
                    "Attributes": {
                        "condition": "true",
                        "enabled": true,
                        "endpoint_names": [
                            "export2"
                        ],
                        "name": "export2",
                        "source": "DeviceMessages"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 86,
                        "startLine": 80
                    }
                },
                {
                    "Type": "enrichment",
                    "Labels": [],
                    "Attributes": {
                        "endpoint_names": [
                            "export",
                            "export2"
                        ],
                        "key": "tenant",
                        "value": "$twin.tags.Tenant"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 92,
                        "startLine": 88
                    }
                },
                {
                    "Type": "cloud_to_device",
                    "Labels": [],
                    "Attributes": {
                        "default_ttl": "PT1H",
                        "max_delivery_count": "30"
                    },
                    "Blocks": [
                        {
                            "Type": "feedback",
                            "Labels": [],
                            "Attributes": {
                                "lock_duration": "PT30S",
                                "max_delivery_count": "15",
                                "time_to_live": "PT1H10M"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 101,
                                "startLine": 97
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 102,
                        "startLine": 94
                    }
                }
            ],
            "line_range": {
                "endLine": 107,
                "startLine": 43
            }
        }
    ]
    count(result) == 1
}
