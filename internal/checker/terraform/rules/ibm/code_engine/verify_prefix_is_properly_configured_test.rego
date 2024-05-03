package lib.terraform.CB_TFIBM_104
import rego.v1

test_proper_format_configuration_pass if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_code_engine_binding",
            "code_engine_binding_instance"
        ],
        "Attributes": {
            "prefix": "MY_COS",
            "project_id": "15314cc3-85b4-4338-903f-c28cde",
            "secret_name": "my-service-access"
        },
        "Blocks": [
            {
                "Type": "component",
                "Labels": [],
                "Attributes": {
                    "name": "my-app-1",
                    "resource_type": "app_v2"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 5,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_proper_format_configuration_fail if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_code_engine_binding",
            "code_engine_binding_instance"
        ],
        "Attributes": {
            "prefix": "my_carbonetes_account_validation_0212359012561027",
            "project_id": "15314cc3-85b4-4338-903f-c28cde",
            "secret_name": "my-service-access"
        },
        "Blocks": [
            {
                "Type": "component",
                "Labels": [],
                "Attributes": {
                    "name": "my-app-1",
                    "resource_type": "app_v2"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 5,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }
]
	count(result) == 1
}
