package lib.terraform.CB_TFIBM_030

import rego.v1

test_data_not_transmitted_envi_variables_pass if {
	result := passed with input as [{
           "Type": "resource",
            "Labels": [
                "ibm_cm_validation",
                "cm_version_validation"
            ],
            "Attributes": {
                "environment_variables": {
                    "name": "example_env_var_name",
                    "secure": true,
                    "value": "example_env_var_value"
                }
            }
    }]
	count(result) == 1
}

test_data_not_transmitted_envi_variables_fail if {
	result := failed with input as [{
            "Type": "resource",
            "Labels": [
                "ibm_cm_validation",
                "cm_version_validation"
            ],
            "Attributes": {
                "environment_variables": {
                    "name": "example_env_var_name",
                    "secure": false,
                    "value": "example_env_var_value"
                }
            }
    }]
	count(result) == 1
}
