package lib.terraform.CB_TFIBM_103
import rego.v1

test_project_id_set_pass if {
    result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_code_engine_binding",
            "code_engine_binding_instance"
        ],
        "Attributes": {
            "prefix": "MY_COS",
            "project_id": "15314cc3-85b4-4338-903f-c28cdee6d005",
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

test_project_id_set_fail if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_code_engine_binding",
            "code_engine_binding_instance"
        ],
        "Attributes": {
            "prefix": "MY_COS",
            "project_id": "1534cc3-854-433-903f-c28cee6d005",
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
