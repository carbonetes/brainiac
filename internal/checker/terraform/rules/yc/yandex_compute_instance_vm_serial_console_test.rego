package lib.terraform.CB_TFYC_004

test_yandex_compute_instance_vm_serial_console_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_compute_instance",
            "default"
        ],
        "Attributes": {
            "name": "test",
            "platform_id": "standard-v1",
            "zone": "ru-central1-a"
        },
        "Blocks": [
            {
                "Type": "resources",
                "Labels": [],
                "Attributes": {
                    "cores": "2",
                    "memory": "4"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 6
                }
            },
            {
                "Type": "boot_disk",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "initialize_params",
                        "Labels": [],
                        "Attributes": {
                            "image_id": "image_id"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 14,
                            "startLine": 12
                        }
                    }
                ],
                "line_range": {
                    "endLine": 15,
                    "startLine": 11
                }
            },
            {
                "Type": "network_interface",
                "Labels": [],
                "Attributes": {
                    "subnet_id": "yandex_vpc_subnet.foo.id"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 19,
                    "startLine": 17
                }
            }
        ],
        "line_range": {
            "endLine": 25,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_vpc_network",
            "foo"
        ],
        "Attributes": {},
        "Blocks": [],
        "line_range": {
            "endLine": 27,
            "startLine": 27
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_vpc_subnet",
            "foo"
        ],
        "Attributes": {
            "network_id": "yandex_vpc_network.foo.id",
            "zone": "ru-central1-a"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 32,
            "startLine": 29
        }
    }]
	count(result) == 1
}

test_yandex_compute_instance_vm_serial_console_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_compute_instance",
            "default"
        ],
        "Attributes": {
            "name": "test",
            "platform_id": "standard-v1",
            "zone": "ru-central1-a",
            "metadata": {
            	"serial-port-enable": true
            }
        },
        "Blocks": [
            {
                "Type": "resources",
                "Labels": [],
                "Attributes": {
                    "cores": "2",
                    "memory": "4"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 6
                }
            },
            {
                "Type": "boot_disk",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "initialize_params",
                        "Labels": [],
                        "Attributes": {
                            "image_id": "image_id"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 14,
                            "startLine": 12
                        }
                    }
                ],
                "line_range": {
                    "endLine": 15,
                    "startLine": 11
                }
            },
            {
                "Type": "network_interface",
                "Labels": [],
                "Attributes": {
                    "subnet_id": "yandex_vpc_subnet.foo.id"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 19,
                    "startLine": 17
                }
            }
        ],
        "line_range": {
            "endLine": 25,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_vpc_network",
            "foo"
        ],
        "Attributes": {},
        "Blocks": [],
        "line_range": {
            "endLine": 27,
            "startLine": 27
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_vpc_subnet",
            "foo"
        ],
        "Attributes": {
            "network_id": "yandex_vpc_network.foo.id",
            "zone": "ru-central1-a"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 32,
            "startLine": 29
        }
    }]
	count(result) == 1
}