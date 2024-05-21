package lib.terraform.CB_TFIBM_111

import rego.v1

test_pipeline_property_value_secure_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cd_tekton_pipeline_property",
            "cd_tekton_pipeline_property_instance"
        ],
        "Attributes": {
            "locked": false,
            "name": "prop1",
            "pipeline_id": "94619026-912b-4d92-8f51-6c74f0692d90",
            "type": "text",
            "value": "https://github.com/open-toolchain/hello-tekton.git"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_pipeline_property_value_secure_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cd_tekton_pipeline_property",
            "cd_tekton_pipeline_property_instance"
        ],
        "Attributes": {
            "locked": false,
            "name": "prop1",
            "pipeline_id": "94619026-912b-4d92-8f51-6c74f0692d90",
            "type": "text",
            "value": "http://github.com/open-toolchain/hello-tekton.git"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }]
	count(result) == 1
}
