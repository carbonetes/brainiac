package lib.terraform.CB_TFYC_008

test_yandex_kubernetes_node_group_auto_upgrade_enabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_kubernetes_node_group",
            "my_node_group"
        ],
        "Attributes": {
            "cluster_id": "yandex_kubernetes_cluster.my_cluster.id",
            "description": "description",
            "labels": {
                "key": "value"
            },
            "name": "name",
            "version": "1.17"
        },
        "Blocks": [
            {
                "Type": "instance_template",
                "Labels": [],
                "Attributes": {
                    "platform_id": "standard-v2"
                },
                "Blocks": [
                    {
                        "Type": "network_interface",
                        "Labels": [],
                        "Attributes": {
                            "nat": true,
                            "subnet_ids": "yandex_vpc_subnet.my_subnet.id"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 17,
                            "startLine": 14
                        }
                    },
                    {
                        "Type": "resources",
                        "Labels": [],
                        "Attributes": {
                            "cores": "2",
                            "memory": "2"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 22,
                            "startLine": 19
                        }
                    },
                    {
                        "Type": "boot_disk",
                        "Labels": [],
                        "Attributes": {
                            "size": "64",
                            "type": "network-hdd"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 27,
                            "startLine": 24
                        }
                    },
                    {
                        "Type": "scheduling_policy",
                        "Labels": [],
                        "Attributes": {
                            "preemptible": false
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 31,
                            "startLine": 29
                        }
                    }
                ],
                "line_range": {
                    "endLine": 32,
                    "startLine": 11
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
                            "size": "1"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 37,
                            "startLine": 35
                        }
                    }
                ],
                "line_range": {
                    "endLine": 38,
                    "startLine": 34
                }
            },
            {
                "Type": "allocation_policy",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "location",
                        "Labels": [],
                        "Attributes": {
                            "zone": "ru-central1-a"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 43,
                            "startLine": 41
                        }
                    }
                ],
                "line_range": {
                    "endLine": 44,
                    "startLine": 40
                }
            },
            {
                "Type": "maintenance_policy",
                "Labels": [],
                "Attributes": {
                    "auto_repair": true,
                    "auto_upgrade": true
                },
                "Blocks": [
                    {
                        "Type": "maintenance_window",
                        "Labels": [],
                        "Attributes": {
                            "day": "monday",
                            "duration": "3h",
                            "start_time": "15:00"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 54,
                            "startLine": 50
                        }
                    },
                    {
                        "Type": "maintenance_window",
                        "Labels": [],
                        "Attributes": {
                            "day": "friday",
                            "duration": "4h30m",
                            "start_time": "10:00"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 60,
                            "startLine": 56
                        }
                    }
                ],
                "line_range": {
                    "endLine": 61,
                    "startLine": 46
                }
            }
        ],
        "line_range": {
            "endLine": 62,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_yandex_kubernetes_node_group_auto_upgrade_enabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_kubernetes_node_group",
            "my_node_group"
        ],
        "Attributes": {
            "cluster_id": "yandex_kubernetes_cluster.my_cluster.id",
            "description": "description",
            "labels": {
                "key": "value"
            },
            "name": "name",
            "version": "1.17"
        },
        "Blocks": [
            {
                "Type": "instance_template",
                "Labels": [],
                "Attributes": {
                    "platform_id": "standard-v2"
                },
                "Blocks": [
                    {
                        "Type": "network_interface",
                        "Labels": [],
                        "Attributes": {
                            "nat": true,
                            "subnet_ids": "yandex_vpc_subnet.my_subnet.id"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 17,
                            "startLine": 14
                        }
                    },
                    {
                        "Type": "resources",
                        "Labels": [],
                        "Attributes": {
                            "cores": "2",
                            "memory": "2"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 22,
                            "startLine": 19
                        }
                    },
                    {
                        "Type": "boot_disk",
                        "Labels": [],
                        "Attributes": {
                            "size": "64",
                            "type": "network-hdd"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 27,
                            "startLine": 24
                        }
                    },
                    {
                        "Type": "scheduling_policy",
                        "Labels": [],
                        "Attributes": {
                            "preemptible": false
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 31,
                            "startLine": 29
                        }
                    }
                ],
                "line_range": {
                    "endLine": 32,
                    "startLine": 11
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
                            "size": "1"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 37,
                            "startLine": 35
                        }
                    }
                ],
                "line_range": {
                    "endLine": 38,
                    "startLine": 34
                }
            },
            {
                "Type": "allocation_policy",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "location",
                        "Labels": [],
                        "Attributes": {
                            "zone": "ru-central1-a"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 43,
                            "startLine": 41
                        }
                    }
                ],
                "line_range": {
                    "endLine": 44,
                    "startLine": 40
                }
            },
            {
                "Type": "maintenance_policy",
                "Labels": [],
                "Attributes": {
                    "auto_repair": true,
                    "auto_upgrade": false,
                },
                "Blocks": [
                    {
                        "Type": "maintenance_window",
                        "Labels": [],
                        "Attributes": {
                            "day": "monday",
                            "duration": "3h",
                            "start_time": "15:00"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 54,
                            "startLine": 50
                        }
                    },
                    {
                        "Type": "maintenance_window",
                        "Labels": [],
                        "Attributes": {
                            "day": "friday",
                            "duration": "4h30m",
                            "start_time": "10:00"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 60,
                            "startLine": 56
                        }
                    }
                ],
                "line_range": {
                    "endLine": 61,
                    "startLine": 46
                }
            }
        ],
        "line_range": {
            "endLine": 62,
            "startLine": 1
        }
    }]
	count(result) == 1
}