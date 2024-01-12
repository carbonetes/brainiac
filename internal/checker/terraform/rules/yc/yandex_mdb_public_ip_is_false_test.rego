package lib.terraform.CB_TFYC_012

test_yandex_mdb_public_ip_is_false_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_mdb_clickhouse_cluster",
            "foo"
        ],
        "Attributes": {
            "environment": "PRESTABLE",
            "name": "ha",
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
                            "endLine": 11,
                            "startLine": 7
                        }
                    }
                ],
                "line_range": {
                    "endLine": 12,
                    "startLine": 6
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
                            "endLine": 19,
                            "startLine": 15
                        }
                    }
                ],
                "line_range": {
                    "endLine": 20,
                    "startLine": 14
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
                    "endLine": 24,
                    "startLine": 22
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
                            "endLine": 31,
                            "startLine": 29
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
                            "endLine": 36,
                            "startLine": 32
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
                            "endLine": 41,
                            "startLine": 37
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
                            "endLine": 46,
                            "startLine": 42
                        }
                    }
                ],
                "line_range": {
                    "endLine": 47,
                    "startLine": 26
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "subnet_id": "yandex_vpc_subnet.foo.id",
                    "type": "CLICKHOUSE",
                    "zone": "ru-central1-a"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 53,
                    "startLine": 49
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "subnet_id": "yandex_vpc_subnet.bar.id",
                    "type": "CLICKHOUSE",
                    "zone": "ru-central1-b"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 59,
                    "startLine": 55
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "assign_public_ip": false,
                    "subnet_id": "yandex_vpc_subnet.foo.id",
                    "type": "ZOOKEEPER",
                    "zone": "ru-central1-a"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 66,
                    "startLine": 61
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "subnet_id": "yandex_vpc_subnet.bar.id",
                    "type": "ZOOKEEPER",
                    "zone": "ru-central1-b"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 72,
                    "startLine": 68
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "subnet_id": "yandex_vpc_subnet.baz.id",
                    "type": "ZOOKEEPER",
                    "zone": "ru-central1-c"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 78,
                    "startLine": 74
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
                    "endLine": 82,
                    "startLine": 80
                }
            }
        ],
        "line_range": {
            "endLine": 83,
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
            "endLine": 85,
            "startLine": 85
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
            "endLine": 91,
            "startLine": 87
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
            "endLine": 97,
            "startLine": 93
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
            "endLine": 103,
            "startLine": 99
        }
    }]
	count(result) == 1
}

test_yandex_mdb_kafka_cluster_public_ip_is_false_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_mdb_kafka_cluster",
            "foo"
        ],
        "Attributes": {
            "environment": "PRESTABLE",
            "name": "test",
            "network_id": "yandex_vpc_network.foo.id",
            "subnet_ids": "yandex_vpc_subnet.foo.id"
        },
        "Blocks": [
            {
                "Type": "config",
                "Labels": [],
                "Attributes": {
                    "assign_public_ip": false,
                    "brokers_count": "1",
                    "schema_registry": false,
                    "unmanaged_topics": false,
                    "version": "2.6",
                    "zones": [
                        "ru-central1-a"
                    ]
                },
                "Blocks": [
                    {
                        "Type": "kafka",
                        "Labels": [],
                        "Attributes": {},
                        "Blocks": [
                            {
                                "Type": "resources",
                                "Labels": [],
                                "Attributes": {
                                    "disk_size": "32",
                                    "disk_type_id": "network-ssd",
                                    "resource_preset_id": "s2.micro"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 19,
                                    "startLine": 15
                                }
                            },
                            {
                                "Type": "kafka_config",
                                "Labels": [],
                                "Attributes": {
                                    "compression_type": "COMPRESSION_TYPE_ZSTD",
                                    "default_replication_factor": "1",
                                    "log_flush_interval_messages": "1024",
                                    "log_flush_interval_ms": "1000",
                                    "log_flush_scheduler_interval_ms": "1000",
                                    "log_preallocate": true,
                                    "log_retention_bytes": "1.073741824e+09",
                                    "log_retention_hours": "168",
                                    "log_retention_minutes": "10080",
                                    "log_retention_ms": "8.64e+07",
                                    "log_segment_bytes": "1.34217728e+08",
                                    "num_partitions": "10"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 33,
                                    "startLine": 20
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 34,
                            "startLine": 14
                        }
                    }
                ],
                "line_range": {
                    "endLine": 35,
                    "startLine": 7
                }
            },
            {
                "Type": "user",
                "Labels": [],
                "Attributes": {
                    "name": "producer-application",
                    "password": "password"
                },
                "Blocks": [
                    {
                        "Type": "permission",
                        "Labels": [],
                        "Attributes": {
                            "role": "ACCESS_ROLE_PRODUCER",
                            "topic_name": "input"
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
                    "startLine": 37
                }
            },
            {
                "Type": "user",
                "Labels": [],
                "Attributes": {
                    "name": "worker",
                    "password": "password"
                },
                "Blocks": [
                    {
                        "Type": "permission",
                        "Labels": [],
                        "Attributes": {
                            "role": "ACCESS_ROLE_CONSUMER",
                            "topic_name": "input"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 52,
                            "startLine": 49
                        }
                    },
                    {
                        "Type": "permission",
                        "Labels": [],
                        "Attributes": {
                            "role": "ACCESS_ROLE_PRODUCER",
                            "topic_name": "output"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 56,
                            "startLine": 53
                        }
                    }
                ],
                "line_range": {
                    "endLine": 57,
                    "startLine": 46
                }
            }
        ],
        "line_range": {
            "endLine": 58,
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
            "endLine": 60,
            "startLine": 60
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
                "10.5.0.0/24"
            ],
            "zone": "ru-central1-a"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 66,
            "startLine": 62
        }
    }]
	count(result) == 1
}

test_yandex_mdb_greenplum_cluster_public_ip_is_false_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_mdb_kafka_cluster",
            "foo"
        ],
        "Attributes": {
            "environment": "PRESTABLE",
            "name": "test",
            "network_id": "yandex_vpc_network.foo.id",
            "subnet_ids": "yandex_vpc_subnet.foo.id"
        },
        "Blocks": [
            {
                "Type": "config",
                "Labels": [],
                "Attributes": {
                    "assign_public_ip": false,
                    "brokers_count": "1",
                    "schema_registry": false,
                    "unmanaged_topics": false,
                    "version": "2.6",
                    "zones": [
                        "ru-central1-a"
                    ]
                },
                "Blocks": [
                    {
                        "Type": "kafka",
                        "Labels": [],
                        "Attributes": {},
                        "Blocks": [
                            {
                                "Type": "resources",
                                "Labels": [],
                                "Attributes": {
                                    "disk_size": "32",
                                    "disk_type_id": "network-ssd",
                                    "resource_preset_id": "s2.micro"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 19,
                                    "startLine": 15
                                }
                            },
                            {
                                "Type": "kafka_config",
                                "Labels": [],
                                "Attributes": {
                                    "compression_type": "COMPRESSION_TYPE_ZSTD",
                                    "default_replication_factor": "1",
                                    "log_flush_interval_messages": "1024",
                                    "log_flush_interval_ms": "1000",
                                    "log_flush_scheduler_interval_ms": "1000",
                                    "log_preallocate": true,
                                    "log_retention_bytes": "1.073741824e+09",
                                    "log_retention_hours": "168",
                                    "log_retention_minutes": "10080",
                                    "log_retention_ms": "8.64e+07",
                                    "log_segment_bytes": "1.34217728e+08",
                                    "num_partitions": "10"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 33,
                                    "startLine": 20
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 34,
                            "startLine": 14
                        }
                    }
                ],
                "line_range": {
                    "endLine": 35,
                    "startLine": 7
                }
            },
            {
                "Type": "user",
                "Labels": [],
                "Attributes": {
                    "name": "producer-application",
                    "password": "password"
                },
                "Blocks": [
                    {
                        "Type": "permission",
                        "Labels": [],
                        "Attributes": {
                            "role": "ACCESS_ROLE_PRODUCER",
                            "topic_name": "input"
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
                    "startLine": 37
                }
            },
            {
                "Type": "user",
                "Labels": [],
                "Attributes": {
                    "name": "worker",
                    "password": "password"
                },
                "Blocks": [
                    {
                        "Type": "permission",
                        "Labels": [],
                        "Attributes": {
                            "role": "ACCESS_ROLE_CONSUMER",
                            "topic_name": "input"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 52,
                            "startLine": 49
                        }
                    },
                    {
                        "Type": "permission",
                        "Labels": [],
                        "Attributes": {
                            "role": "ACCESS_ROLE_PRODUCER",
                            "topic_name": "output"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 56,
                            "startLine": 53
                        }
                    }
                ],
                "line_range": {
                    "endLine": 57,
                    "startLine": 46
                }
            }
        ],
        "line_range": {
            "endLine": 58,
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
            "endLine": 60,
            "startLine": 60
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
                "10.5.0.0/24"
            ],
            "zone": "ru-central1-a"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 66,
            "startLine": 62
        }
    }]
	count(result) == 1
}

test_yandex_compute_instance_vm_public_ip_test_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_mdb_clickhouse_cluster",
            "foo"
        ],
        "Attributes": {
            "environment": "PRESTABLE",
            "name": "ha",
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
                            "endLine": 11,
                            "startLine": 7
                        }
                    }
                ],
                "line_range": {
                    "endLine": 12,
                    "startLine": 6
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
                            "endLine": 19,
                            "startLine": 15
                        }
                    }
                ],
                "line_range": {
                    "endLine": 20,
                    "startLine": 14
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
                    "endLine": 24,
                    "startLine": 22
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
                            "endLine": 31,
                            "startLine": 29
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
                            "endLine": 36,
                            "startLine": 32
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
                            "endLine": 41,
                            "startLine": 37
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
                            "endLine": 46,
                            "startLine": 42
                        }
                    }
                ],
                "line_range": {
                    "endLine": 47,
                    "startLine": 26
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "subnet_id": "yandex_vpc_subnet.foo.id",
                    "type": "CLICKHOUSE",
                    "zone": "ru-central1-a"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 53,
                    "startLine": 49
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "subnet_id": "yandex_vpc_subnet.bar.id",
                    "type": "CLICKHOUSE",
                    "zone": "ru-central1-b"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 59,
                    "startLine": 55
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "assign_public_ip": true,
                    "subnet_id": "yandex_vpc_subnet.foo.id",
                    "type": "ZOOKEEPER",
                    "zone": "ru-central1-a"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 66,
                    "startLine": 61
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "subnet_id": "yandex_vpc_subnet.bar.id",
                    "type": "ZOOKEEPER",
                    "zone": "ru-central1-b"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 72,
                    "startLine": 68
                }
            },
            {
                "Type": "host",
                "Labels": [],
                "Attributes": {
                    "subnet_id": "yandex_vpc_subnet.baz.id",
                    "type": "ZOOKEEPER",
                    "zone": "ru-central1-c"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 78,
                    "startLine": 74
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
                    "endLine": 82,
                    "startLine": 80
                }
            }
        ],
        "line_range": {
            "endLine": 83,
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
            "endLine": 85,
            "startLine": 85
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
            "endLine": 91,
            "startLine": 87
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
            "endLine": 97,
            "startLine": 93
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
            "endLine": 103,
            "startLine": 99
        }
    }]
	count(result) == 1
}


test_yandex_mdb_kafka_cluster_public_ip_is_false_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_mdb_kafka_cluster",
            "foo"
        ],
        "Attributes": {
            "environment": "PRESTABLE",
            "name": "test",
            "network_id": "yandex_vpc_network.foo.id",
            "subnet_ids": "yandex_vpc_subnet.foo.id"
        },
        "Blocks": [
            {
                "Type": "config",
                "Labels": [],
                "Attributes": {
                    "assign_public_ip": true,
                    "brokers_count": "1",
                    "schema_registry": false,
                    "unmanaged_topics": false,
                    "version": "2.6",
                    "zones": [
                        "ru-central1-a"
                    ]
                },
                "Blocks": [
                    {
                        "Type": "kafka",
                        "Labels": [],
                        "Attributes": {},
                        "Blocks": [
                            {
                                "Type": "resources",
                                "Labels": [],
                                "Attributes": {
                                    "disk_size": "32",
                                    "disk_type_id": "network-ssd",
                                    "resource_preset_id": "s2.micro"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 19,
                                    "startLine": 15
                                }
                            },
                            {
                                "Type": "kafka_config",
                                "Labels": [],
                                "Attributes": {
                                    "compression_type": "COMPRESSION_TYPE_ZSTD",
                                    "default_replication_factor": "1",
                                    "log_flush_interval_messages": "1024",
                                    "log_flush_interval_ms": "1000",
                                    "log_flush_scheduler_interval_ms": "1000",
                                    "log_preallocate": true,
                                    "log_retention_bytes": "1.073741824e+09",
                                    "log_retention_hours": "168",
                                    "log_retention_minutes": "10080",
                                    "log_retention_ms": "8.64e+07",
                                    "log_segment_bytes": "1.34217728e+08",
                                    "num_partitions": "10"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 33,
                                    "startLine": 20
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 34,
                            "startLine": 14
                        }
                    }
                ],
                "line_range": {
                    "endLine": 35,
                    "startLine": 7
                }
            },
            {
                "Type": "user",
                "Labels": [],
                "Attributes": {
                    "name": "producer-application",
                    "password": "password"
                },
                "Blocks": [
                    {
                        "Type": "permission",
                        "Labels": [],
                        "Attributes": {
                            "role": "ACCESS_ROLE_PRODUCER",
                            "topic_name": "input"
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
                    "startLine": 37
                }
            },
            {
                "Type": "user",
                "Labels": [],
                "Attributes": {
                    "name": "worker",
                    "password": "password"
                },
                "Blocks": [
                    {
                        "Type": "permission",
                        "Labels": [],
                        "Attributes": {
                            "role": "ACCESS_ROLE_CONSUMER",
                            "topic_name": "input"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 52,
                            "startLine": 49
                        }
                    },
                    {
                        "Type": "permission",
                        "Labels": [],
                        "Attributes": {
                            "role": "ACCESS_ROLE_PRODUCER",
                            "topic_name": "output"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 56,
                            "startLine": 53
                        }
                    }
                ],
                "line_range": {
                    "endLine": 57,
                    "startLine": 46
                }
            }
        ],
        "line_range": {
            "endLine": 58,
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
            "endLine": 60,
            "startLine": 60
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
                "10.5.0.0/24"
            ],
            "zone": "ru-central1-a"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 66,
            "startLine": 62
        }
    }]
	count(result) == 1
}

test_yandex_mdb_greenplum_cluster_public_ip_is_false_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_mdb_kafka_cluster",
            "foo"
        ],
        "Attributes": {
            "environment": "PRESTABLE",
            "name": "test",
            "network_id": "yandex_vpc_network.foo.id",
            "subnet_ids": "yandex_vpc_subnet.foo.id"
        },
        "Blocks": [
            {
                "Type": "config",
                "Labels": [],
                "Attributes": {
                    "assign_public_ip": true,
                    "brokers_count": "1",
                    "schema_registry": false,
                    "unmanaged_topics": false,
                    "version": "2.6",
                    "zones": [
                        "ru-central1-a"
                    ]
                },
                "Blocks": [
                    {
                        "Type": "kafka",
                        "Labels": [],
                        "Attributes": {},
                        "Blocks": [
                            {
                                "Type": "resources",
                                "Labels": [],
                                "Attributes": {
                                    "disk_size": "32",
                                    "disk_type_id": "network-ssd",
                                    "resource_preset_id": "s2.micro"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 19,
                                    "startLine": 15
                                }
                            },
                            {
                                "Type": "kafka_config",
                                "Labels": [],
                                "Attributes": {
                                    "compression_type": "COMPRESSION_TYPE_ZSTD",
                                    "default_replication_factor": "1",
                                    "log_flush_interval_messages": "1024",
                                    "log_flush_interval_ms": "1000",
                                    "log_flush_scheduler_interval_ms": "1000",
                                    "log_preallocate": true,
                                    "log_retention_bytes": "1.073741824e+09",
                                    "log_retention_hours": "168",
                                    "log_retention_minutes": "10080",
                                    "log_retention_ms": "8.64e+07",
                                    "log_segment_bytes": "1.34217728e+08",
                                    "num_partitions": "10"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 33,
                                    "startLine": 20
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 34,
                            "startLine": 14
                        }
                    }
                ],
                "line_range": {
                    "endLine": 35,
                    "startLine": 7
                }
            },
            {
                "Type": "user",
                "Labels": [],
                "Attributes": {
                    "name": "producer-application",
                    "password": "password"
                },
                "Blocks": [
                    {
                        "Type": "permission",
                        "Labels": [],
                        "Attributes": {
                            "role": "ACCESS_ROLE_PRODUCER",
                            "topic_name": "input"
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
                    "startLine": 37
                }
            },
            {
                "Type": "user",
                "Labels": [],
                "Attributes": {
                    "name": "worker",
                    "password": "password"
                },
                "Blocks": [
                    {
                        "Type": "permission",
                        "Labels": [],
                        "Attributes": {
                            "role": "ACCESS_ROLE_CONSUMER",
                            "topic_name": "input"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 52,
                            "startLine": 49
                        }
                    },
                    {
                        "Type": "permission",
                        "Labels": [],
                        "Attributes": {
                            "role": "ACCESS_ROLE_PRODUCER",
                            "topic_name": "output"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 56,
                            "startLine": 53
                        }
                    }
                ],
                "line_range": {
                    "endLine": 57,
                    "startLine": 46
                }
            }
        ],
        "line_range": {
            "endLine": 58,
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
            "endLine": 60,
            "startLine": 60
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
                "10.5.0.0/24"
            ],
            "zone": "ru-central1-a"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 66,
            "startLine": 62
        }
    }]
	count(result) == 1
}