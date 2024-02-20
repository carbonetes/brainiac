package lib.terraform.CB_TFRAN_066

test_rancher2_cluster_gke_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "foo"
        ],
        "Attributes": {
            "description": "foo test",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "amazonec2_credential_config",
                "Labels": [],
                "Attributes": {
                    "access_key": "<AWS_ACCESS_KEY>",
                    "secret_key": "<AWS_SECRET_KEY>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 4
                }
            }
        ],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "rancher2_cluster",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform EKS cluster",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "gke_config",
                "Labels": [],
                "Attributes": {
                    "cluster_ipv4_cidr": "<cluster_ipv4_cidr>",
                    "credential": "<credential>",
                    "disk_type": "<disk_type>",
                    "image_type": "<image_type>",
                    "ip_policy_cluster_ipv4_cidr_block": "<ip_policy_cluster_ipv4_cidr_block>",
                    "ip_policy_node_ipv4_cidr_block": [
                        "<some_ip_address_1>",
                        "<some_ip_address_2>",
                        "<some_ip_address_3>",
                        "<some_ip_address_4>"
                    ],
                    "ip_policy_services_ipv4_cidr_block": [
                        "<some_ip_address_1>",
                        "<some_ip_address_2>",
                        "<some_ip_address_3>",
                        "<some_ip_address_4>"
                    ],
                    "ip_policy_services_secondary_range_name": "<ip_policy_services_secondary_range_name>",
                    "ip_policy_subnetwork_name": "<ip_policy_subnetwork_name>",
                    "locations": [
                        "<location_1>",
                        "<location_2>"
                    ],
                    "machine_type": "<machine_type>",
                    "maintenance_type": "<maintenance_type>",
                    "maintenance_window": "<maintenance_window>",
                    "master_ipv4_cidr_block": "<master_ipv4_cidr_block>",
                    "master_version": "<master_version>",
                    "network": "<network>",
                    "node_pool": "<node_pool>",
                    "node_version": "<node_version>",
                    "oauth_scopes": "<oauth_scopes>",
                    "project_id": "<project_id>",
                    "service_account": "<service_account>",
                    "sub_network": "<sub_network>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 48,
                    "startLine": 12
                }
            }
        ],
        "line_range": {
            "endLine": 49,
            "startLine": 9
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_gke_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster",
            "foo-custom"
        ],
        "Attributes": {
            "description": "Foo rancher2 custom cluster",
            "name": "foo-custom"
        },
        "Blocks": [
            {
                "Type": "gke_config",
                "Labels": [],
                "Attributes": {
                    "cluster_ipv4_cidr": "<cluster_ipv4_cidr>",
                    "credential": "<credential>",
                    "disk_type": "<disk_type>",
                    "image_type": "<image_type>",
                    "ip_policy_cluster_ipv4_cidr_block": "<ip_policy_cluster_ipv4_cidr_block>",
                    "ip_policy_node_ipv4_cidr_block": [
                        "<some_ip_address_1>",
                        "<some_ip_address_2>",
                        "<some_ip_address_3>",
                        "<some_ip_address_4>"
                    ],
                    "ip_policy_services_ipv4_cidr_block": [
                        "<some_ip_address_1>",
                        "<some_ip_address_2>",
                        "<some_ip_address_3>",
                        "<some_ip_address_4>"
                    ],
                    "ip_policy_services_secondary_range_name": "<ip_policy_services_secondary_range_name>",
                    "ip_policy_subnetwork_name": "<ip_policy_subnetwork_name>",
                    "locations": [
                        "<location_1>",
                        "<location_2>"
                    ],
                    "machine_type": "<machine_type>",
                    "maintenance_type": "<maintenance_type>",
                    "maintenance_window": "<maintenance_window>",
                    "master_ipv4_cidr_block": "<master_ipv4_cidr_block>",
                    "master_version": "<master_version>",
                    "network": "<network>",
                    "node_pool": "<node_pool>",
                    "node_version": "<node_version>",
                    "oauth_scopes": "<oauth_scopes>",
                    "project_id": "<project_id>",
                    "service_account": "<service_account>",
                    "sub_network": "<sub_network>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 48,
                    "startLine": 12
                }
            },
            {
                "Type": "aks_config_v2",
                "Labels": [],
                "Attributes": {
                    "cloud_credential_id": "rancher2_cloud_credential.foo-aks.id",
                    "imported": true,
                    "resource_group": "<RESOURCE_GROUP>",
                    "resource_location": "<RESOURCE_LOCATION>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 30,
                    "startLine": 25
                }
            }
        ],
        "line_range": {
            "endLine": 31,
            "startLine": 2
        }
    }]
    count(result) == 1
}