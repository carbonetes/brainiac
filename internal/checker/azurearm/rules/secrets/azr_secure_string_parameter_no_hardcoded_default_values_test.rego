package lib.azurearm.CB_AZR_071

test_azr_secure_string_parameter_no_hardcoded_default_values_exist {
	result := passed with input as {
        "resources": [
            {
                "type": "secureString"
            }
        ]
    }
	count(result) == 1
}

test_azr_secure_string_parameter_no_hardcoded_default_values_not_exist {
	result := failed with input as {
        "resources": [
            {
                "type": "secureString",
                "defaultValue": "myHardcodedValue"
            }
        ]
    }
	count(result) == 1
}
