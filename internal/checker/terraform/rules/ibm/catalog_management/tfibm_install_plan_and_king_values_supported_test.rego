package lib.terraform.CB_TFIBM_023

import rego.v1

test_install_plan_and_king_values_pass if {
	result := passed with input as [ {
        "Type": "resource",
        "Labels": [
            "ibm_cm_offering_instance",
            "cm_offering_instance"
        ],
        "Attributes": {
            "catalog_id": "catalog_id_123",
            "channel": "beta_channel",
            "cluster_all_namespaces": false,
            "cluster_region": "us-south",
            "crn": "crn_123456789",
            "id": "instance_id_987654321",
            "install_plan": "Automatic",
            "kind_format": "operator-bundle",
            "label": "my_operator_instance",
        }
    }]
	count(result) == 1
}

test_install_plan_and_king_values_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cm_offering_instance",
            "cm_offering_instance"
        ],
        "Attributes": {
            "catalog_id": "catalog_id_123",
            "channel": "beta_channel",
            "cluster_all_namespaces": false,
            "cluster_region": "us-south",
            "crn": "crn_123456789",
            "id": "instance_id_987654321",
            "install_plan": "AUTOMATIC",
            "kind_format": "ova",
            "label": "my_operator_instance",
        }
    }]
	count(result) == 1
}
