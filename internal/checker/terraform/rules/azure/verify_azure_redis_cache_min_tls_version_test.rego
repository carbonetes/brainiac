package lib.terraform.CB_TFAZR_133

test_azure_redis_cache_min_tls_version_passed {
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
            "pass"
        ],
        "Attributes": {
            "minimum_tls_version": "1.2"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_azure_redis_cache_min_tls_version_failed {
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
            "pass"
        ],
        "Attributes": {
            "minimum_tls_version": "1.1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 5
        }
    }]
	count(result) == 1
}