package lib.terraform.CB_TFIBM_024

import rego.v1

test_supported_cluster_region_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cm_offering_instance",
            "cm_offering_instance"
        ],
        "Attributes": {
            "catalog_id": "catalog_id_123",
            "channel": "beta_channel",
            "cluster_region": "us-south",
            "crn": "crn_123456789",
        }
    }]
	count(result) == 1
}

test_supported_cluster_region_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cm_offering_instance",
            "cm_offering_instance"
        ],
        "Attributes": {
            "catalog_id": "catalog_id_123",
            "channel": "beta_channel",
            "cluster_region": "ph",
            "crn": "crn_123456789",
        }
    }]
	count(result) == 1
}
