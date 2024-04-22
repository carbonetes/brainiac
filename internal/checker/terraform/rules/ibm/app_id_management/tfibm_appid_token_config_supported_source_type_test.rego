package lib.terraform.CB_TFIBM_067

import rego.v1 

test_tfibm_appid_token_config_is_supported_source_type_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_token_config",
            "tc"
        ],
        "Attributes": {
            "access_token_expires_in": "7200",
            "anonymous_access_enabled": true,
            "anonymous_token_expires_in": "3200",
            "refresh_token_enabled": false,
            "tenant_id": "var.tenant_id"
        },
        "Blocks": [
            {
                "Type": "access_token_claim",
                "Labels": [],
                "Attributes": {
                    "destination_claim": "groupIds",
                    "source": "roles"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 8
                }
            },
            {
                "Type": "access_token_claim",
                "Labels": [],
                "Attributes": {
                    "destination_claim": "employeeId",
                    "source": "appid_custom",
                    "source_claim": "employeeId"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 13
                }
            },
            {
                "Type": "access_token_claim",
                "Labels": [],
                "Attributes": {
                    "destination_claim": "employeeId",
                    "source": "saml",
                    "source_claim": "attributes.uid"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 23,
                    "startLine": 19
                }
            }
        ],
        "line_range": {
            "endLine": 24,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_tfibm_appid_token_config_is_not_supported_source_type_failed if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_token_config",
            "tc"
        ],
        "Attributes": {
            "access_token_expires_in": "7200",
            "anonymous_access_enabled": true,
            "anonymous_token_expires_in": "3200",
            "refresh_token_enabled": false,
            "tenant_id": "var.tenant_id"
        },
        "Blocks": [
            {
                "Type": "access_token_claim",
                "Labels": [],
                "Attributes": {
                    "destination_claim": "groupIds",
                    "source": "roles"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 8
                }
            },
            {
                "Type": "access_token_claim",
                "Labels": [],
                "Attributes": {
                    "destination_claim": "employeeId",
                    "source": "test",
                    "source_claim": "employeeId"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 13
                }
            },
            {
                "Type": "access_token_claim",
                "Labels": [],
                "Attributes": {
                    "destination_claim": "employeeId",
                    "source": "saml",
                    "source_claim": "attributes.uid"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 23,
                    "startLine": 19
                }
            }
        ],
        "line_range": {
            "endLine": 24,
            "startLine": 1
        }
    }
]
	count(result) == 1
}