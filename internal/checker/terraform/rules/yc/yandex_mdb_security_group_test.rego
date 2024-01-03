package lib.terraform.CB_TFYC_001

test_yandex_mdb_security_group_passed { 
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_mdb_clickhouse_cluster",
            "foo"
        ],
        "Attributes": {
            "environment": "PRODUCTION",
            "name": "sharded",
            "network_id": "yandex_vpc_network.foo.id",
            "security_group_ids": [
                "your-security-group-id"
            ]
        },
        "Blocks": [
            {
                "Type": "clickhouse",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "resources",
                        "Labels": [],
                        "Attributes": {
                            "disk_size": "16",
                            "disk_type_id": "network-ssd",
                            "resource_preset_id": "s2.micro"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 12,
                            "startLine": 8
                        }
                    }
                ],
                "line_range": {
                    "endLine": 13,
                    "startLine": 7
                }
            },
            {
                "Type": "zookeeper",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "resources",
                        "Labels": [],
                        "Attributes": {
                            "disk_size": "10",
                            "disk_type_id": "network-ssd",
                            "resource_preset_id": "s2.micro"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 20,
                            "startLine": 16
                        }
                    }
                ],
                "line_range": {
                    "endLine": 21,
                    "startLine": 15
                }
            },
            {
                "Type": "database",
                "Labels": [],
                "Attributes": {
                    "name": "db_name"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 25,
                    "startLine": 23
                }
            },
            {
                "Type": "user",
                "Labels": [],
                "Attributes": {
                    "name": "user",
                    "password": "password"
                },
                "Blocks": [
                    {
                        "Type": "permission",
                        "Labels": [],
                        "Attributes": {
                            "database_name": "db_name"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 32,
                            "startLine": 30
                        }
                    },
                    {
                        "Type": "settings",
                        "Labels": [],
                        "Attributes": {
                            "max_memory_usage_for_user": "1e+09",
                            "output_format_json_quote_64bit_integers": true,
                            "read_overflow_mode": "throw"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 37,
                            "startLine": 33
                        }
                    },
                    {
                        "Type": "quota",
                        "Labels": [],
                        "Attributes": {
                            "errors": "1000",
                            "interval_duration": "3.6e+06",
                            "queries": "10000"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 42,
                            "startLine": 38
                        }
                    },
                    {
                        "Type": "quota",
                        "Labels": [],
                        "Attributes": {
                            "error": "5000",
                            "interval_duration": "7.98e+07",
                            "queries": "50000"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 47,
                            "startLine": 43
                        }
                    }
                ],
                "line_range": {
                    "endLine": 48,
                    "startLine": 27
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "shard_name": "shard1",
                    "subnet_id": "yandex_vpc_subnet.foo.id",
                    "type": "CLICKHOUSE",
                    "zone": "ru-central1-a"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 55,
                    "startLine": 50
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "shard_name": "shard1",
                    "subnet_id": "yandex_vpc_subnet.bar.id",
                    "type": "CLICKHOUSE",
                    "zone": "ru-central1-b"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 62,
                    "startLine": 57
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "shard_name": "shard2",
                    "subnet_id": "yandex_vpc_subnet.bar.id",
                    "type": "CLICKHOUSE",
                    "zone": "ru-central1-b"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 69,
                    "startLine": 64
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "shard_name": "shard2",
                    "subnet_id": "yandex_vpc_subnet.baz.id",
                    "type": "CLICKHOUSE",
                    "zone": "ru-central1-c"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 76,
                    "startLine": 71
                }
            },
            {
                "Type": "shard_group",
                "Labels": [],
                "Attributes": {
                    "description": "Cluster configuration that contain only shard1",
                    "name": "single_shard_group",
                    "shard_names": [
                        "shard1"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 84,
                    "startLine": 78
                }
            },
            {
                "Type": "cloud_storage",
                "Labels": [],
                "Attributes": {
                    "enabled": false
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 88,
                    "startLine": 86
                }
            }
        ],
        "line_range": {
            "endLine": 89,
            "startLine": 2
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
            "endLine": 91,
            "startLine": 91
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
            "v4_cidr_blocks": [
                "10.1.0.0/24"
            ],
            "zone": "ru-central1-a"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 97,
            "startLine": 93
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_vpc_subnet",
            "bar"
        ],
        "Attributes": {
            "network_id": "yandex_vpc_network.foo.id",
            "v4_cidr_blocks": [
                "10.2.0.0/24"
            ],
            "zone": "ru-central1-b"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 103,
            "startLine": 99
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_vpc_subnet",
            "baz"
        ],
        "Attributes": {
            "network_id": "yandex_vpc_network.foo.id",
            "v4_cidr_blocks": [
                "10.3.0.0/24"
            ],
            "zone": "ru-central1-c"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 109,
            "startLine": 105
        }
    }]
	count(result) == 1
}

test_yandex_mdb_security_group_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_mdb_clickhouse_cluster",
            "foo"
        ],
        "Attributes": {
            "environment": "PRODUCTION",
            "name": "sharded",
            "network_id": "yandex_vpc_network.foo.id"
        },
        "Blocks": [
            {
                "Type": "clickhouse",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "resources",
                        "Labels": [],
                        "Attributes": {
                            "disk_size": "16",
                            "disk_type_id": "network-ssd",
                            "resource_preset_id": "s2.micro"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 12,
                            "startLine": 8
                        }
                    }
                ],
                "line_range": {
                    "endLine": 13,
                    "startLine": 7
                }
            },
            {
                "Type": "zookeeper",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "resources",
                        "Labels": [],
                        "Attributes": {
                            "disk_size": "10",
                            "disk_type_id": "network-ssd",
                            "resource_preset_id": "s2.micro"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 20,
                            "startLine": 16
                        }
                    }
                ],
                "line_range": {
                    "endLine": 21,
                    "startLine": 15
                }
            },
            {
                "Type": "database",
                "Labels": [],
                "Attributes": {
                    "name": "db_name"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 25,
                    "startLine": 23
                }
            },
            {
                "Type": "user",
                "Labels": [],
                "Attributes": {
                    "name": "user",
                    "password": "password"
                },
                "Blocks": [
                    {
                        "Type": "permission",
                        "Labels": [],
                        "Attributes": {
                            "database_name": "db_name"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 32,
                            "startLine": 30
                        }
                    },
                    {
                        "Type": "settings",
                        "Labels": [],
                        "Attributes": {
                            "max_memory_usage_for_user": "1e+09",
                            "output_format_json_quote_64bit_integers": true,
                            "read_overflow_mode": "throw"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 37,
                            "startLine": 33
                        }
                    },
                    {
                        "Type": "quota",
                        "Labels": [],
                        "Attributes": {
                            "errors": "1000",
                            "interval_duration": "3.6e+06",
                            "queries": "10000"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 42,
                            "startLine": 38
                        }
                    },
                    {
                        "Type": "quota",
                        "Labels": [],
                        "Attributes": {
                            "error": "5000",
                            "interval_duration": "7.98e+07",
                            "queries": "50000"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 47,
                            "startLine": 43
                        }
                    }
                ],
                "line_range": {
                    "endLine": 48,
                    "startLine": 27
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "shard_name": "shard1",
                    "subnet_id": "yandex_vpc_subnet.foo.id",
                    "type": "CLICKHOUSE",
                    "zone": "ru-central1-a"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 55,
                    "startLine": 50
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "shard_name": "shard1",
                    "subnet_id": "yandex_vpc_subnet.bar.id",
                    "type": "CLICKHOUSE",
                    "zone": "ru-central1-b"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 62,
                    "startLine": 57
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "shard_name": "shard2",
                    "subnet_id": "yandex_vpc_subnet.bar.id",
                    "type": "CLICKHOUSE",
                    "zone": "ru-central1-b"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 69,
                    "startLine": 64
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "shard_name": "shard2",
                    "subnet_id": "yandex_vpc_subnet.baz.id",
                    "type": "CLICKHOUSE",
                    "zone": "ru-central1-c"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 76,
                    "startLine": 71
                }
            },
            {
                "Type": "shard_group",
                "Labels": [],
                "Attributes": {
                    "description": "Cluster configuration that contain only shard1",
                    "name": "single_shard_group",
                    "shard_names": [
                        "shard1"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 84,
                    "startLine": 78
                }
            },
            {
                "Type": "cloud_storage",
                "Labels": [],
                "Attributes": {
                    "enabled": false
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 88,
                    "startLine": 86
                }
            }
        ],
        "line_range": {
            "endLine": 89,
            "startLine": 2
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
            "endLine": 91,
            "startLine": 91
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
            "v4_cidr_blocks": [
                "10.1.0.0/24"
            ],
            "zone": "ru-central1-a"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 97,
            "startLine": 93
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_vpc_subnet",
            "bar"
        ],
        "Attributes": {
            "network_id": "yandex_vpc_network.foo.id",
            "v4_cidr_blocks": [
                "10.2.0.0/24"
            ],
            "zone": "ru-central1-b"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 103,
            "startLine": 99
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_vpc_subnet",
            "baz"
        ],
        "Attributes": {
            "network_id": "yandex_vpc_network.foo.id",
            "v4_cidr_blocks": [
                "10.3.0.0/24"
            ],
            "zone": "ru-central1-c"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 109,
            "startLine": 105
        }
    }]
	count(result) == 1
}