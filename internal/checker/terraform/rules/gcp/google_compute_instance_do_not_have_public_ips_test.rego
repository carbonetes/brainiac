package lib.terraform.CB_TFGCP_088

test_google_compute_instance_do_not_have_public_ips_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_service_account",
            "default"
        ],
        "Attributes": {
            "account_id": "my-custom-sa",
            "display_name": "Custom SA for VM Instance"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_compute_instance",
            "default"
        ],
        "Attributes": {
            "machine_type": "n2-standard-2",
            "metadata": {
                "foo": "bar"
            },
            "metadata_startup_script": "echo hi > /test.txt",
            "name": "my-instance",
            "tags": [
                "foo",
                "bar"
            ],
            "zone": "us-central1-a"
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
                            "image": "debian-cloud/debian-11",
                            "labels": {
                                "my_label": "value"
                            }
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 19,
                            "startLine": 14
                        }
                    }
                ],
                "line_range": {
                    "endLine": 20,
                    "startLine": 13
                }
            },
            {
                "Type": "scratch_disk",
                "Labels": [],
                "Attributes": {
                    "interface": "NVME"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 25,
                    "startLine": 23
                }
            },
            {
                "Type": "network_interface",
                "Labels": [],
                "Attributes": {
                    "network": "default"
                },
                "line_range": {
                    "endLine": 33,
                    "startLine": 27
                }
            },
            {
                "Type": "service_account",
                "Labels": [],
                "Attributes": {
                    "email": "google_service_account.default.email",
                    "scopes": [
                        "cloud-platform"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 45,
                    "startLine": 41
                }
            }
        ],
        "line_range": {
            "endLine": 46,
            "startLine": 6
        }
    }]
count(result) == 1
}

test_google_compute_instance_do_not_have_public_ips_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_service_account",
            "default"
        ],
        "Attributes": {
            "account_id": "my-custom-sa",
            "display_name": "Custom SA for VM Instance"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_compute_instance",
            "default"
        ],
        "Attributes": {
            "machine_type": "n2-standard-2",
            "metadata": {
                "foo": "bar"
            },
            "metadata_startup_script": "echo hi > /test.txt",
            "name": "my-instance",
            "tags": [
                "foo",
                "bar"
            ],
            "zone": "us-central1-a"
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
                            "image": "debian-cloud/debian-11",
                            "labels": {
                                "my_label": "value"
                            }
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 19,
                            "startLine": 14
                        }
                    }
                ],
                "line_range": {
                    "endLine": 20,
                    "startLine": 13
                }
            },
            {
                "Type": "scratch_disk",
                "Labels": [],
                "Attributes": {
                    "interface": "NVME"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 25,
                    "startLine": 23
                }
            },
            {
                "Type": "network_interface",
                "Labels": [],
                "Attributes": {
                    "network": "default"
                },
                "Blocks": [
                    {
                        "Type": "access_config",
                        "Labels": [],
                        "Attributes": {},
                        "Blocks": [],
                        "line_range": {
                            "endLine": 32,
                            "startLine": 30
                        }
                    }
                ],
                "line_range": {
                    "endLine": 33,
                    "startLine": 27
                }
            },
            {
                "Type": "service_account",
                "Labels": [],
                "Attributes": {
                    "email": "google_service_account.default.email",
                    "scopes": [
                        "cloud-platform"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 45,
                    "startLine": 41
                }
            }
        ],
        "line_range": {
            "endLine": 46,
            "startLine": 6
        }
    }]
count(result) == 1
}