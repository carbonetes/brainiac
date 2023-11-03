package lib.terraform.CB_TFAZR_096

test_azure_redis_cache_public_network_access_enabled_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "azurerm"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "features",
                "Labels": [],
                "Attributes": {},
                "Blocks": [],
                "line_range": {
                    "endLine": 2,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_redis_cache",
            "example"
        ],
        "Attributes": {
            "public_network_access_enabled": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_azure_redis_cache_public_network_access_enabled_failed {
	result := failed with input as [{
        "Type": "provider",
        "Labels": [
            "azurerm"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "features",
                "Labels": [],
                "Attributes": {},
                "Blocks": [],
                "line_range": {
                    "endLine": 2,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_redis_cache",
            "example"
        ],
        "Attributes": {
            "public_network_access_enabled": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 5
        }
    }]
	count(result) == 1
}