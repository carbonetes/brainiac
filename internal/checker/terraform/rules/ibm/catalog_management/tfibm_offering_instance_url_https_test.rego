package lib.terraform.CB_TFIBM_022

import rego.v1

test_offering_instance_url_https_pass if {
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
            "label": "my_operator_instance",
            "offering_id": "offering_id_789",
            "schematics_workspace_id": "workspace_id_abc123",
            "url": "https://example.com",
            "version": "v1.2.3"
        }
    }]
	count(result) == 1
}

test_offering_instance_url_https_fail if {
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
            "cluster_id": "cluster_id_456",
            "label": "my_operator_instance",
            "offering_id": "offering_id_789",
            "schematics_workspace_id": "workspace_id_abc123",
            "url": "http://example.com",
            "version": "v1.2.3"
        }
    }]
	count(result) == 1
}
