package lib.terraform.CB_TFIBM_005

import rego.v1

test_trusted_profile_properly_defined_pass if {
	result := passed with input as [{
            "Type": "resource",
            "Labels": [
                "ibm_cm_catalog",
                "cm_catalog"
            ],
            "Blocks": [
                {
                    "Attributes": {
                        "api_key": "api_key",
                        "label": "Sample Target Account",
                        "name": "sample_account",
                        "project_id": "489498"
                    },
                    "Blocks": [
                        {
                            "Attributes": {
                                "target_service_id": "service_456",
                                "trusted_profile_id": "profile_141"
                            }
                        }
                    ]
                }
            ]
    }]
	count(result) == 1
}

test_trusted_profile_properly_defined_fail if {
	result := failed with input as [{
            "Type": "resource",
            "Labels": [
                "ibm_cm_catalog",
                "cm_catalog"
            ],
            "Blocks": [
                {
                    "Attributes": {
                        "api_key": "api_key",
                        "label": "Sample Target Account",
                        "name": "sample_account",
                        "project_id": "489498"
                    },
                    "Blocks": [
                        {
                            "Attributes": {
                                "target_service_id": "",
                                "trusted_profile_id": ""
                            }
                        }
                    ]
                }
            ]
    }]
	count(result) == 1
}
