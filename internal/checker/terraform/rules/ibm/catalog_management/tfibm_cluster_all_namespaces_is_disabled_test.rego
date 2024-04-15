package lib.terraform.CB_TFIBM_025

import rego.v1

test_cluster_all_namespaces_is_disabled_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cm_offering_instance",
            "cm_offering_instance"
        ],
        "Attributes": {
            "catalog_id": "catalog_id_123",
            "channel": "beta_channel",
            "cluster_all_namespaces": false,
            "cluster_id": "cluster_id_456",
        }
    }]
	count(result) == 1
}

test_cluster_all_namespaces_is_disabled_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cm_offering_instance",
            "cm_offering_instance"
        ],
        "Attributes": {
            "catalog_id": "catalog_id_123",
            "channel": "beta_channel",
            "cluster_all_namespaces": true,
            "cluster_id": "cluster_id_456",
        }
    }]
	count(result) == 1
}
