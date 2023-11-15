package lib.terraform.CB_TFGCP_080

test_google_compute_instance_disk_encryption_passed {
	result := passed with input as [{
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
                            "raw_key": "base64_key_sample",
                            "disk_encryption_key_raw": "disk_encryption_key_raw_sample"
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
            }
        ],
        "line_range": {
            "endLine": 18,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_google_compute_instance_disk_encryption_failed {
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
            }
        ],
        "line_range": {
            "endLine": 18,
            "startLine": 1
        }
    }]
	count(result) == 1
}
