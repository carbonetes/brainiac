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
            "cluster_all_namespaces": false,
            "cluster_id": "cluster_id_456",
            "cluster_namespaces": [
                "namespace1",
                "namespace2"
            ],
            "cluster_region": "us-south",
            "crn": "crn_123456789",
            "id": "instance_id_987654321",
            "install_plan": "automatic",
            "kind_format": "operator",
            "label": "my_operator_instance",
            "offering_id": "offering_id_789",
            "schematics_workspace_id": "workspace_id_abc123",
            "url": "https://example.com",
            "version": "v1.2.3"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 1
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
            "cluster_all_namespaces": false,
            "cluster_id": "cluster_id_456",
            "cluster_namespaces": [
                "namespace1",
                "namespace2"
            ],
            "cluster_region": "ph",
            "crn": "crn_123456789",
            "id": "instance_id_987654321",
            "install_plan": "automatic",
            "kind_format": "operator",
            "label": "my_operator_instance",
            "offering_id": "offering_id_789",
            "schematics_workspace_id": "workspace_id_abc123",
            "url": "https://example.com",
            "version": "v1.2.3"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 1
        }
    }]
	count(result) == 1
}
