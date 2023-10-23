package lib.terraform.CB_TFAZR_196

test_azurerm_cdn_endpoint_custom_domain_tls_protocol_12_passed {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "west europe",
                "name": "example-rg"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 5,
                "startLine": 2
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_storage_account",
                "example"
            ],
            "Attributes": {
                "account_replication_type": "GRS",
                "account_tier": "Standard",
                "location": "azurerm_resource_group.example.location",
                "name": "example",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 13,
                "startLine": 7
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_cdn_profile",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-profile",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "Standard_Verizon"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 20,
                "startLine": 15
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_cdn_endpoint",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-endpoint",
                "profile_name": "azurerm_cdn_profile.example.name",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "origin",
                    "Labels": [],
                    "Attributes": {
                        "host_name": "azurerm_storage_account.example.primary_blob_host",
                        "name": "example"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 31,
                        "startLine": 28
                    }
                }
            ],
            "line_range": {
                "endLine": 32,
                "startLine": 22
            }
        },
        {
            "Type": "data",
            "Labels": [
                "azurerm_dns_zone",
                "example"
            ],
            "Attributes": {
                "name": "example-domain.com",
                "resource_group_name": "domain-rg"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 37,
                "startLine": 34
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_dns_cname_record",
                "example"
            ],
            "Attributes": {
                "name": "example",
                "resource_group_name": "data.azurerm_dns_zone.example.resource_group_name",
                "target_resource_id": "azurerm_cdn_endpoint.example.id",
                "ttl": "3600",
                "zone_name": "data.azurerm_dns_zone.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 45,
                "startLine": 39
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_cdn_endpoint_custom_domain",
                "example"
            ],
            "Attributes": {
                "cdn_endpoint_id": "azurerm_cdn_endpoint.example.id",
                "host_name": "azurerm_dns_cname_record.example.name",
                "name": "example-domain"
            },
            "Blocks": [
                {
                    "Type": "cdn_managed_https",
                    "Labels": [],
                    "Attributes": {
                        "certificate_type": "Shared",
                        "protocol_type": "IPBased",
                        "tls_version": "TLS12"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 55,
                        "startLine": 51
                    }
                }
            ],
            "line_range": {
                "endLine": 56,
                "startLine": 47
            }
        }
    ]
    count(result) == 1
}

test_azurerm_cdn_endpoint_custom_domain_tls_protocol_12_failed {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "west europe",
                "name": "example-rg"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 5,
                "startLine": 2
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_storage_account",
                "example"
            ],
            "Attributes": {
                "account_replication_type": "GRS",
                "account_tier": "Standard",
                "location": "azurerm_resource_group.example.location",
                "name": "example",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 13,
                "startLine": 7
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_cdn_profile",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-profile",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "Standard_Verizon"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 20,
                "startLine": 15
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_cdn_endpoint",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-endpoint",
                "profile_name": "azurerm_cdn_profile.example.name",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "origin",
                    "Labels": [],
                    "Attributes": {
                        "host_name": "azurerm_storage_account.example.primary_blob_host",
                        "name": "example"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 31,
                        "startLine": 28
                    }
                }
            ],
            "line_range": {
                "endLine": 32,
                "startLine": 22
            }
        },
        {
            "Type": "data",
            "Labels": [
                "azurerm_dns_zone",
                "example"
            ],
            "Attributes": {
                "name": "example-domain.com",
                "resource_group_name": "domain-rg"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 37,
                "startLine": 34
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_dns_cname_record",
                "example"
            ],
            "Attributes": {
                "name": "example",
                "resource_group_name": "data.azurerm_dns_zone.example.resource_group_name",
                "target_resource_id": "azurerm_cdn_endpoint.example.id",
                "ttl": "3600",
                "zone_name": "data.azurerm_dns_zone.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 45,
                "startLine": 39
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_cdn_endpoint_custom_domain",
                "example"
            ],
            "Attributes": {
                "cdn_endpoint_id": "azurerm_cdn_endpoint.example.id",
                "host_name": "azurerm_dns_cname_record.example.name",
                "name": "example-domain"
            },
            "Blocks": [
                {
                    "Type": "cdn_managed_https",
                    "Labels": [],
                    "Attributes": {
                        "certificate_type": "Shared",
                        "protocol_type": "IPBased",
                        "tls_version": "TLS10"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 55,
                        "startLine": 51
                    }
                }
            ],
            "line_range": {
                "endLine": 56,
                "startLine": 47
            }
        }
    ]
    count(result) == 1
}