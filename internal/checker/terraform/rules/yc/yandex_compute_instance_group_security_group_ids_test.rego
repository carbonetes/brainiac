package lib.terraform.CB_TFYC_022

test_yandex_compute_instance_group_security_group_ids_passed { 
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_compute_instance_group",
            "group1"
        ],
        "Attributes": {
            "deletion_protection": true,
            "folder_id": "data.yandex_resourcemanager_folder.test_folder.id",
            "name": "test-ig",
            "service_account_id": "yandex_iam_service_account.test_account.id",
            "variables": {
                "test_key1": "test_value1",
                "test_key2": "test_value2"
            }
        },
        "Blocks": [
            {
                "Type": "instance_template",
                "Labels": [],
                "Attributes": {
                    "labels": {
                        "label1": "label1-value",
                        "label2": "label2-value"
                    },
                    "platform_id": "standard-v1"
                },
                "Blocks": [
                    {
                        "Type": "resources",
                        "Labels": [],
                        "Attributes": {
                            "cores": "2",
                            "memory": "1"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 11,
                            "startLine": 8
                        }
                    },
                    {
                        "Type": "boot_disk",
                        "Labels": [],
                        "Attributes": {
                            "mode": "READ_WRITE"
                        },
                        "Blocks": [
                            {
                                "Type": "initialize_params",
                                "Labels": [],
                                "Attributes": {
                                    "image_id": "data.yandex_compute_image.ubuntu.id",
                                    "size": "4"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 17,
                                    "startLine": 14
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 18,
                            "startLine": 12
                        }
                    },
                    {
                        "Type": "network_interface",
                        "Labels": [],
                        "Attributes": {
                            "network_id": "yandex_vpc_network.my-inst-group-network.id",
                            "security_group_ids": "yandex_vpc_subnet.my-inst-group-subnet.id",
                            "subnet_ids": "yandex_vpc_subnet.my-inst-group-subnet.id"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 23,
                            "startLine": 19
                        }
                    },
                    {
                        "Type": "network_settings",
                        "Labels": [],
                        "Attributes": {
                            "type": "STANDARD"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 34,
                            "startLine": 32
                        }
                    }
                ],
                "line_range": {
                    "endLine": 35,
                    "startLine": 6
                }
            },
            {
                "Type": "scale_policy",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "fixed_scale",
                        "Labels": [],
                        "Attributes": {
                            "size": "3"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 45,
                            "startLine": 43
                        }
                    }
                ],
                "line_range": {
                    "endLine": 46,
                    "startLine": 42
                }
            },
            {
                "Type": "allocation_policy",
                "Labels": [],
                "Attributes": {
                    "zones": [
                        "ru-central1-a"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 50,
                    "startLine": 48
                }
            },
            {
                "Type": "deploy_policy",
                "Labels": [],
                "Attributes": {
                    "max_creating": "2",
                    "max_deleting": "2",
                    "max_expansion": "2",
                    "max_unavailable": "2"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 57,
                    "startLine": 52
                }
            }
        ],
        "line_range": {
            "endLine": 58,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_yandex_compute_instance_group_security_group_ids_failed { 
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_compute_instance_group",
            "group1"
        ],
        "Attributes": {
            "deletion_protection": true,
            "folder_id": "data.yandex_resourcemanager_folder.test_folder.id",
            "name": "test-ig",
            "service_account_id": "yandex_iam_service_account.test_account.id",
            "variables": {
                "test_key1": "test_value1",
                "test_key2": "test_value2"
            }
        },
        "Blocks": [
            {
                "Type": "instance_template",
                "Labels": [],
                "Attributes": {
                    "labels": {
                        "label1": "label1-value",
                        "label2": "label2-value"
                    },
                    "platform_id": "standard-v1"
                },
                "Blocks": [
                    {
                        "Type": "resources",
                        "Labels": [],
                        "Attributes": {
                            "cores": "2",
                            "memory": "1"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 11,
                            "startLine": 8
                        }
                    },
                    {
                        "Type": "boot_disk",
                        "Labels": [],
                        "Attributes": {
                            "mode": "READ_WRITE"
                        },
                        "Blocks": [
                            {
                                "Type": "initialize_params",
                                "Labels": [],
                                "Attributes": {
                                    "image_id": "data.yandex_compute_image.ubuntu.id",
                                    "size": "4"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 17,
                                    "startLine": 14
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 18,
                            "startLine": 12
                        }
                    },
                    {
                        "Type": "network_interface",
                        "Labels": [],
                        "Attributes": {
                            "network_id": "yandex_vpc_network.my-inst-group-network.id",
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 23,
                            "startLine": 19
                        }
                    },
                    {
                        "Type": "network_settings",
                        "Labels": [],
                        "Attributes": {
                            "type": "STANDARD"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 34,
                            "startLine": 32
                        }
                    }
                ],
                "line_range": {
                    "endLine": 35,
                    "startLine": 6
                }
            },
            {
                "Type": "scale_policy",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "fixed_scale",
                        "Labels": [],
                        "Attributes": {
                            "size": "3"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 45,
                            "startLine": 43
                        }
                    }
                ],
                "line_range": {
                    "endLine": 46,
                    "startLine": 42
                }
            },
            {
                "Type": "allocation_policy",
                "Labels": [],
                "Attributes": {
                    "zones": [
                        "ru-central1-a"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 50,
                    "startLine": 48
                }
            },
            {
                "Type": "deploy_policy",
                "Labels": [],
                "Attributes": {
                    "max_creating": "2",
                    "max_deleting": "2",
                    "max_expansion": "2",
                    "max_unavailable": "2"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 57,
                    "startLine": 52
                }
            }
        ],
        "line_range": {
            "endLine": 58,
            "startLine": 1
        }
    }]
	count(result) == 1
}