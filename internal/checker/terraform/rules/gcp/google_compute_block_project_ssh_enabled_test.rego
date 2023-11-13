package lib.terraform.CB_TFGCP_054

test_google_compute_block_project_ssh_enabled_passed {
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
                "block-project-ssh-keys-metadata": "block-project-ssh-keys"
            },
            "metadata_startup_script": "echo hi > /test.txt",
            "name": "gke-my-instance",
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
                    "endLine": 24,
                    "startLine": 22
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
                            "endLine": 31,
                            "startLine": 29
                        }
                    }
                ],
                "line_range": {
                    "endLine": 32,
                    "startLine": 26
                }
            },
            {
                "Type": "service_account",
                "Labels": [],
                "Attributes": {
                    "email": "google_service_account.default.email",
                    "scopes": [
                        "not-cloud-platform"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 43,
                    "startLine": 40
                }
            }
        ],
        "line_range": {
            "endLine": 44,
            "startLine": 6
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_compute_instance_from_template",
            "tpl"
        ],
        "Attributes": {
            "can_ip_forward": false,
            "labels": {
                "my_key": "my_value"
            },
            "name": "gke-instance-from-template",
            "zone": "us-central1-a"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 57,
            "startLine": 46
        }
    }]
	count(result) == 1
}

test_google_compute_block_project_ssh_enabled_failed {
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
                "block-project-ssh-keys-metadata": "not-block-project-ssh-keys"
            },
            "metadata_startup_script": "echo hi > /test.txt",
            "name": "gke-my-instance",
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
                    "endLine": 24,
                    "startLine": 22
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
                            "endLine": 31,
                            "startLine": 29
                        }
                    }
                ],
                "line_range": {
                    "endLine": 32,
                    "startLine": 26
                }
            },
            {
                "Type": "service_account",
                "Labels": [],
                "Attributes": {
                    "email": "google_service_account.default.email",
                    "scopes": [
                        "not-cloud-platform"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 43,
                    "startLine": 40
                }
            }
        ],
        "line_range": {
            "endLine": 44,
            "startLine": 6
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_compute_instance_from_template",
            "tpl"
        ],
        "Attributes": {
            "can_ip_forward": false,
            "labels": {
                "my_key": "my_value"
            },
            "name": "gke-instance-from-template",
            "zone": "us-central1-a"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 57,
            "startLine": 46
        }
    }]
	count(result) == 1
}
