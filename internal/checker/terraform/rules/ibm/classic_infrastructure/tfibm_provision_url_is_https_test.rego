package lib.terraform.CB_TFIBM_047

import rego.v1

test_domain_not_exposed_information_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_compute_provisioning_hook",
            "test_provisioning_hook"
        ],
        "Attributes": {
            "name": "test_provisioning_hook_name",
            "uri": "https://raw.githubusercontent.com/test/slvm/master/test-script.sh"
        }
    }]
	count(result) == 1
}

test_domain_not_exposed_information_fail if {
	result := failed with input as [{
                "Type": "resource",
        "Labels": [
            "ibm_compute_provisioning_hook",
            "test_provisioning_hook"
        ],
        "Attributes": {
            "name": "test_provisioning_hook_name",
            "uri": "http://raw.githubusercontent.com/test/slvm/master/test-script.sh"
        }
    }]
	count(result) == 1
}
