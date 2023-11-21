package lib.terraform.CB_TFGCP_119

test_google_data_fusion_instance_stack_driver_monitoring_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_data_fusion_instance",
            "extended_instance"
        ],
        "Attributes": {
            "dataproc_service_account": "data.google_app_engine_default_service_account.default.email",
            "description": "My Data Fusion instance",
            "display_name": "My Data Fusion instance",
            "enable_stackdriver_logging": true,
            "enable_stackdriver_monitoring": true,
            "labels": {
                "example_key": "example_value"
            },
            "name": "my-instance",
            "private_instance": true,
            "region": "us-central1",
            "type": "BASIC"
        },
        "Blocks": [
            {
                "Type": "network_config",
                "Labels": [],
                "Attributes": {
                    "ip_allocation": "google_compute_global_address.private_ip_alloc.address",
                    "network": "default"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 19,
                    "startLine": 16
                }
            },
            {
                "Type": "accelerators",
                "Labels": [],
                "Attributes": {
                    "accelerator_type": "CDC",
                    "state": "ENABLED"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 24,
                    "startLine": 21
                }
            }
        ],
        "line_range": {
            "endLine": 26,
            "startLine": 1
        }
    },
    {
        "Type": "data",
        "Labels": [
            "google_app_engine_default_service_account",
            "default"
        ],
        "Attributes": {},
        "Blocks": [],
        "line_range": {
            "endLine": 29,
            "startLine": 28
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_compute_network",
            "network"
        ],
        "Attributes": {
            "name": "datafusion-full-network"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 33,
            "startLine": 31
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_compute_global_address",
            "private_ip_alloc"
        ],
        "Attributes": {
            "address_type": "INTERNAL",
            "name": "datafusion-ip-alloc",
            "network": "google_compute_network.network.id",
            "prefix_length": "22",
            "purpose": "VPC_PEERING"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 41,
            "startLine": 35
        }
    }]
	count(result) == 1
}

test_google_data_fusion_instance_stack_driver_monitoring_failed {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "google_data_fusion_instance",
            "extended_instance"
        ],
        "Attributes": {
            "dataproc_service_account": "data.google_app_engine_default_service_account.default.email",
            "description": "My Data Fusion instance",
            "display_name": "My Data Fusion instance",
            "enable_stackdriver_logging": false,
            "enable_stackdriver_monitoring": false,
            "labels": {
                "example_key": "example_value"
            },
            "name": "my-instance",
            "private_instance": true,
            "region": "us-central1",
            "type": "BASIC"
        },
        "Blocks": [
            {
                "Type": "network_config",
                "Labels": [],
                "Attributes": {
                    "ip_allocation": "google_compute_global_address.private_ip_alloc.address",
                    "network": "default"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 19,
                    "startLine": 16
                }
            },
            {
                "Type": "accelerators",
                "Labels": [],
                "Attributes": {
                    "accelerator_type": "CDC",
                    "state": "ENABLED"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 24,
                    "startLine": 21
                }
            }
        ],
        "line_range": {
            "endLine": 26,
            "startLine": 1
        }
    },
    {
        "Type": "data",
        "Labels": [
            "google_app_engine_default_service_account",
            "default"
        ],
        "Attributes": {},
        "Blocks": [],
        "line_range": {
            "endLine": 29,
            "startLine": 28
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_compute_network",
            "network"
        ],
        "Attributes": {
            "name": "datafusion-full-network"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 33,
            "startLine": 31
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_compute_global_address",
            "private_ip_alloc"
        ],
        "Attributes": {
            "address_type": "INTERNAL",
            "name": "datafusion-ip-alloc",
            "network": "google_compute_network.network.id",
            "prefix_length": "22",
            "purpose": "VPC_PEERING"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 41,
            "startLine": 35
        }
    }]
	count(result) == 1
}
