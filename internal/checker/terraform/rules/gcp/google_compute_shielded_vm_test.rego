package lib.terraform.CB_TFGCP_057

test_google_compute_shielded_vm_passed {
	result := passed with input as [{
        "Attributes": {
            "machine_type": "n1-standard-1",
            "name": "example-instance"
        },
        "Blocks": [
            {
                "Attributes": {},
                "Blocks": [
                    {
                        "Attributes": {
                            "image": "debian-cloud/debian-10"
                        },
                        "Blocks": [],
                        "Labels": [],
                        "Type": "initialize_params",
                        "line_range": {
                            "endLine": 8,
                            "startLine": 6
                        }
                    },
                    {
                        "Attributes": {
                            "disk_encryption_key_raw": "disk_encryption_key_raw_sample",
                            "kms_key_self_link": "kms_key_self_link_sample",
                            "raw_key": "base64_key_sample"
                        },
                        "Blocks": [],
                        "Labels": [],
                        "Type": "disk_encryption_key",
                        "line_range": {
                            "endLine": 12,
                            "startLine": 9
                        }
                    }
                ],
                "Labels": [],
                "Type": "boot_disk",
                "line_range": {
                    "endLine": 13,
                    "startLine": 5
                }
            },
            {
                "Attributes": {
                    "network": "default"
                },
                "Blocks": [],
                "Labels": [],
                "Type": "network_interface",
                "line_range": {
                    "endLine": 17,
                    "startLine": 15
                }
            }
        ],
        "Labels": [
            "google_compute_instance",
            "example_instance"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 18,
            "startLine": 1
        }
    }]
count(result) == 1
}

test_google_compute_shielded_vm_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_compute_instance",
            "example_instance"
        ],
        "Attributes": {
            "machine_type": "n1-standard-1",
            "name": "example-instance"
        },
        "Blocks": [
            {
                "Type": "boot_disk",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "initialize_params",
                        "Labels": [],
                        "Attributes": {
                            "image": "debian-cloud/debian-10"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 8,
                            "startLine": 6
                        }
                    },
                    {
                        "Type": "disk_encryption_key",
                        "Labels": [],
                        "Attributes": {
                            "kms_key_self_link": "kms_key_self_link_sample",
                            "raw_key": "base64_key_sample"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 12,
                            "startLine": 9
                        }
                    }
                ],
                "line_range": {
                    "endLine": 13,
                    "startLine": 5
                }
            },
            {
                "Type": "network_interface",
                "Labels": [],
                "Attributes": {
                    "network": "default"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 15
                }
            },
            {
                "Type": "shielded_instance_config",
                "Labels": [],
                "Attributes": {
                    "enable_vtpm": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 21,
                    "startLine": 19
                }
            }
        ],
        "line_range": {
            "endLine": 22,
            "startLine": 1
        }
    }]
count(result) == 1
}