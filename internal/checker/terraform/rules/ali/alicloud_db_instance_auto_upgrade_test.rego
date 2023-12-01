package lib.terraform.CB_TFALI_022

test_alicloud_cs_kubernetes_node_pool_auto_repair_passed {
	result := passed with input as [
    {
        "Type": "variable",
        "Labels": [
            "name"
        ],
        "Attributes": {
            "default": "tf-example"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_zones",
            "default"
        ],
        "Attributes": {
            "available_resource_creation": "VSwitch"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 4
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_images",
            "default"
        ],
        "Attributes": {
            "most_recent": true,
            "name_regex": "^ubuntu_18.*64",
            "owners": "system"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 7
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_instance_types",
            "default"
        ],
        "Attributes": {
            "availability_zone": "data.alicloud_zones.default.zones..id",
            "cpu_core_count": "4",
            "kubernetes_node_role": "Worker",
            "memory_size": "8"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 12
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_vpc",
            "default"
        ],
        "Attributes": {
            "cidr_block": "10.4.0.0/16",
            "vpc_name": "var.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 22,
            "startLine": 19
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_vswitch",
            "default"
        ],
        "Attributes": {
            "cidr_block": "10.4.0.0/24",
            "vpc_id": "alicloud_vpc.default.id",
            "vswitch_name": "var.name",
            "zone_id": "data.alicloud_zones.default.zones..id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 28,
            "startLine": 23
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_managed_kubernetes",
            "default"
        ],
        "Attributes": {
            "cluster_spec": "ack.pro.small",
            "name_prefix": "var.name",
            "new_nat_gateway": true,
            "slb_internet_enabled": true,
            "worker_vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 38,
            "startLine": 30
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_key_pair",
            "default"
        ],
        "Attributes": {
            "key_pair_name": "var.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 42,
            "startLine": 40
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "default"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "instance_types": [
                "ecs.c7.xlarge"
            ],
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "var.name",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 52,
            "startLine": 44
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "desired_size"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "desired_size": "2",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "desired_size",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 64,
            "startLine": 55
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "maintenance"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "desired_size": "1",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "maintenance",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [
            {
                "Type": "management",
                "Labels": [],
                "Attributes": {
                    "auto_repair": true,
                    "auto_upgrade": true,
                    "max_unavailable": "1",
                    "surge": "1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 87,
                    "startLine": 82
                }
            }
        ],
        "line_range": {
            "endLine": 89,
            "startLine": 67
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "scaling_config"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "scaling_config",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [
            {
                "Type": "scaling_config",
                "Labels": [],
                "Attributes": {
                    "max_size": "10",
                    "min_size": "1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 106,
                    "startLine": 103
                }
            }
        ],
        "line_range": {
            "endLine": 108,
            "startLine": 92
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "auto_scaling"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "auto_scaling",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [
            {
                "Type": "management",
                "Labels": [],
                "Attributes": {
                    "auto_repair": true,
                    "auto_upgrade": true,
                    "max_unavailable": "1",
                    "surge": "1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 125,
                    "startLine": 120
                }
            },
            {
                "Type": "scaling_config",
                "Labels": [],
                "Attributes": {
                    "max_size": "10",
                    "min_size": "1",
                    "type": "cpu"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 131,
                    "startLine": 127
                }
            }
        ],
        "line_range": {
            "endLine": 132,
            "startLine": 111
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "prepaid_node"
        ],
        "Attributes": {
            "auto_renew": true,
            "auto_renew_period": "1",
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "install_cloud_monitor": true,
            "instance_charge_type": "PrePaid",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "prepaid_node",
            "period": "1",
            "period_unit": "Month",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 152,
            "startLine": 135
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "spot_instance"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "desired_size": "1",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "spot_instance",
            "spot_strategy": "SpotWithPriceLimit",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [
            {
                "Type": "spot_price_limit",
                "Labels": [],
                "Attributes": {
                    "instance_type": "data.alicloud_instance_types.default.instance_types..id",
                    "price_limit": "0.70"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 173,
                    "startLine": 169
                }
            }
        ],
        "line_range": {
            "endLine": 174,
            "startLine": 155
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "spot_auto_scaling"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "spot_auto_scaling",
            "spot_strategy": "SpotWithPriceLimit",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [
            {
                "Type": "scaling_config",
                "Labels": [],
                "Attributes": {
                    "max_size": "10",
                    "min_size": "1",
                    "type": "spot"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 191,
                    "startLine": 187
                }
            },
            {
                "Type": "spot_price_limit",
                "Labels": [],
                "Attributes": {
                    "instance_type": "data.alicloud_instance_types.default.instance_types..id",
                    "price_limit": "0.70"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 197,
                    "startLine": 194
                }
            }
        ],
        "line_range": {
            "endLine": 198,
            "startLine": 177
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "window"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "desired_size": "1",
            "image_id": "win2019_1809_x64_dtc_en-us_40G_alibase_20221221.vhd",
            "image_type": "Windows",
            "instance_charge_type": "PostPaid",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "name": "windows-np",
            "password": "Hello1234",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 215,
            "startLine": 201
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "exist_node"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "format_disk": false,
            "instance_charge_type": "PostPaid",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "instances": [
                "instance_id_01",
                "instance_id_02",
                "instance_id_03"
            ],
            "keep_instance_name": true,
            "name": "existing-node",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 234,
            "startLine": 219
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "customized_kubelet"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "desired_size": "3",
            "instance_charge_type": "PostPaid",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "name": "customized_kubelet",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [
            {
                "Type": "kubelet_configuration",
                "Labels": [],
                "Attributes": {
                    "event_burst": "5",
                    "event_record_qps": "10",
                    "eviction_hard": {
                        "allocatableMemory.available": "2048",
                        "imagefs.available": "10%",
                        "imagefs.inodesFree": "1000",
                        "memory.available": "1024Mi",
                        "nodefs.available": "10%",
                        "nodefs.inodesFree": "1000",
                        "pid.available": "1000"
                    },
                    "kube_reserved": {
                        "cpu": "500m",
                        "memory": "1Gi"
                    },
                    "registry_burst": "5",
                    "registry_pull_qps": "10",
                    "system_reserved": {
                        "cpu": "1",
                        "ephemeral-storage": "10Gi",
                        "memory": "1Gi"
                    }
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 271,
                    "startLine": 248
                }
            },
            {
                "Type": "rolling_policy",
                "Labels": [],
                "Attributes": {
                    "max_parallelism": "1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 276,
                    "startLine": 274
                }
            }
        ],
        "line_range": {
            "endLine": 277,
            "startLine": 237
        }
    }
]
	count(result) == 1
}

test_alicloud_cs_kubernetes_node_pool_auto_repair_failed {
	result := failed with input as [
    {
        "Type": "variable",
        "Labels": [
            "name"
        ],
        "Attributes": {
            "default": "tf-example"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_zones",
            "default"
        ],
        "Attributes": {
            "available_resource_creation": "VSwitch"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 4
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_images",
            "default"
        ],
        "Attributes": {
            "most_recent": true,
            "name_regex": "^ubuntu_18.*64",
            "owners": "system"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 7
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_instance_types",
            "default"
        ],
        "Attributes": {
            "availability_zone": "data.alicloud_zones.default.zones..id",
            "cpu_core_count": "4",
            "kubernetes_node_role": "Worker",
            "memory_size": "8"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 12
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_vpc",
            "default"
        ],
        "Attributes": {
            "cidr_block": "10.4.0.0/16",
            "vpc_name": "var.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 22,
            "startLine": 19
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_vswitch",
            "default"
        ],
        "Attributes": {
            "cidr_block": "10.4.0.0/24",
            "vpc_id": "alicloud_vpc.default.id",
            "vswitch_name": "var.name",
            "zone_id": "data.alicloud_zones.default.zones..id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 28,
            "startLine": 23
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_managed_kubernetes",
            "default"
        ],
        "Attributes": {
            "cluster_spec": "ack.pro.small",
            "name_prefix": "var.name",
            "new_nat_gateway": true,
            "slb_internet_enabled": true,
            "worker_vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 38,
            "startLine": 30
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_key_pair",
            "default"
        ],
        "Attributes": {
            "key_pair_name": "var.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 42,
            "startLine": 40
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "default"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "instance_types": [
                "ecs.c7.xlarge"
            ],
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "var.name",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 52,
            "startLine": 44
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "desired_size"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "desired_size": "2",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "desired_size",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 64,
            "startLine": 55
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "maintenance"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "desired_size": "1",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "maintenance",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [
            {
                "Type": "management",
                "Labels": [],
                "Attributes": {
                    "auto_repair": false,
                    "auto_upgrade": true,
                    "max_unavailable": "1",
                    "surge": "1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 87,
                    "startLine": 82
                }
            }
        ],
        "line_range": {
            "endLine": 89,
            "startLine": 67
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "scaling_config"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "scaling_config",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [
            {
                "Type": "scaling_config",
                "Labels": [],
                "Attributes": {
                    "max_size": "10",
                    "min_size": "1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 106,
                    "startLine": 103
                }
            }
        ],
        "line_range": {
            "endLine": 108,
            "startLine": 92
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "auto_scaling"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "auto_scaling",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [
            {
                "Type": "management",
                "Labels": [],
                "Attributes": {
                    "auto_repair": true,
                    "auto_upgrade": true,
                    "max_unavailable": "1",
                    "surge": "1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 125,
                    "startLine": 120
                }
            },
            {
                "Type": "scaling_config",
                "Labels": [],
                "Attributes": {
                    "max_size": "10",
                    "min_size": "1",
                    "type": "cpu"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 131,
                    "startLine": 127
                }
            }
        ],
        "line_range": {
            "endLine": 132,
            "startLine": 111
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "prepaid_node"
        ],
        "Attributes": {
            "auto_renew": true,
            "auto_renew_period": "1",
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "install_cloud_monitor": true,
            "instance_charge_type": "PrePaid",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "prepaid_node",
            "period": "1",
            "period_unit": "Month",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 152,
            "startLine": 135
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "spot_instance"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "desired_size": "1",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "spot_instance",
            "spot_strategy": "SpotWithPriceLimit",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [
            {
                "Type": "spot_price_limit",
                "Labels": [],
                "Attributes": {
                    "instance_type": "data.alicloud_instance_types.default.instance_types..id",
                    "price_limit": "0.70"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 173,
                    "startLine": 169
                }
            }
        ],
        "line_range": {
            "endLine": 174,
            "startLine": 155
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "spot_auto_scaling"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "key_name": "alicloud_key_pair.default.key_name",
            "name": "spot_auto_scaling",
            "spot_strategy": "SpotWithPriceLimit",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [
            {
                "Type": "scaling_config",
                "Labels": [],
                "Attributes": {
                    "max_size": "10",
                    "min_size": "1",
                    "type": "spot"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 191,
                    "startLine": 187
                }
            },
            {
                "Type": "spot_price_limit",
                "Labels": [],
                "Attributes": {
                    "instance_type": "data.alicloud_instance_types.default.instance_types..id",
                    "price_limit": "0.70"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 197,
                    "startLine": 194
                }
            }
        ],
        "line_range": {
            "endLine": 198,
            "startLine": 177
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "window"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "desired_size": "1",
            "image_id": "win2019_1809_x64_dtc_en-us_40G_alibase_20221221.vhd",
            "image_type": "Windows",
            "instance_charge_type": "PostPaid",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "name": "windows-np",
            "password": "Hello1234",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 215,
            "startLine": 201
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "exist_node"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "format_disk": false,
            "instance_charge_type": "PostPaid",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "instances": [
                "instance_id_01",
                "instance_id_02",
                "instance_id_03"
            ],
            "keep_instance_name": true,
            "name": "existing-node",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 234,
            "startLine": 219
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes_node_pool",
            "customized_kubelet"
        ],
        "Attributes": {
            "cluster_id": "alicloud_cs_managed_kubernetes.default.id",
            "desired_size": "3",
            "instance_charge_type": "PostPaid",
            "instance_types": "data.alicloud_instance_types.default.instance_types..id",
            "name": "customized_kubelet",
            "system_disk_category": "cloud_efficiency",
            "system_disk_size": "40",
            "vswitch_ids": "alicloud_vswitch.default.id"
        },
        "Blocks": [
            {
                "Type": "kubelet_configuration",
                "Labels": [],
                "Attributes": {
                    "event_burst": "5",
                    "event_record_qps": "10",
                    "eviction_hard": {
                        "allocatableMemory.available": "2048",
                        "imagefs.available": "10%",
                        "imagefs.inodesFree": "1000",
                        "memory.available": "1024Mi",
                        "nodefs.available": "10%",
                        "nodefs.inodesFree": "1000",
                        "pid.available": "1000"
                    },
                    "kube_reserved": {
                        "cpu": "500m",
                        "memory": "1Gi"
                    },
                    "registry_burst": "5",
                    "registry_pull_qps": "10",
                    "system_reserved": {
                        "cpu": "1",
                        "ephemeral-storage": "10Gi",
                        "memory": "1Gi"
                    }
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 271,
                    "startLine": 248
                }
            },
            {
                "Type": "rolling_policy",
                "Labels": [],
                "Attributes": {
                    "max_parallelism": "1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 276,
                    "startLine": 274
                }
            }
        ],
        "line_range": {
            "endLine": 277,
            "startLine": 237
        }
    }
]
	count(result) == 1
}