package lib.terraform.CB_TFALI_031

test_alicloud_ecs_launch_template_disks_are_encrypted_passed {
	result := passed with input as [{
        "Type": "data",
        "Labels": [
            "alicloud_zones",
            "default"
        ],
        "Attributes": {
            "available_disk_category": "cloud_efficiency",
            "available_resource_creation": "VSwitch"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 1
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_instance_types",
            "default"
        ],
        "Attributes": {
            "availability_zone": "data.alicloud_zones.default.zones..id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 5
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_images",
            "default"
        ],
        "Attributes": {
            "name_regex": "^ubuntu_[0-9]+_[0-9]+_x64*",
            "owners": "system"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 9
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_vpc",
            "default"
        ],
        "Attributes": {
            "cidr_block": "172.17.3.0/24",
            "vpc_name": "terraform-example"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 14
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_vswitch",
            "default"
        ],
        "Attributes": {
            "cidr_block": "172.17.3.0/24",
            "vpc_id": "alicloud_vpc.default.id",
            "vswitch_name": "terraform-example",
            "zone_id": "data.alicloud_zones.default.zones..id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 24,
            "startLine": 19
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_security_group",
            "default"
        ],
        "Attributes": {
            "name": "terraform-example",
            "vpc_id": "alicloud_vpc.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 29,
            "startLine": 26
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_ecs_launch_template",
            "default"
        ],
        "Attributes": {
            "description": "terraform-example",
            "host_name": "terraform-example",
            "image_id": "data.alicloud_images.default.images..id",
            "instance_charge_type": "PrePaid",
            "instance_name": "terraform-example",
            "instance_type": "data.alicloud_instance_types.default.instance_types..id",
            "internet_charge_type": "PayByBandwidth",
            "internet_max_bandwidth_in": "5",
            "internet_max_bandwidth_out": "5",
            "io_optimized": "optimized",
            "key_pair_name": "key_pair_name",
            "launch_template_name": "terraform-example",
            "network_type": "vpc",
            "ram_role_name": "ram_role_name",
            "security_enhancement_strategy": "Active",
            "security_group_ids": "alicloud_security_group.default.id",
            "spot_price_limit": "5",
            "spot_strategy": "SpotWithPriceLimit",
            "template_tags": {
                "Create": "Terraform",
                "For": "example"
            },
            "user_data": "xxxxxxx",
            "vpc_id": "alicloud_vpc.default.id",
            "vswitch_id": "alicloud_vswitch.default.id",
            "zone_id": "data.alicloud_zones.default.zones..id"
        },
        "Blocks": [
            {
                "Type": "system_disk",
                "Labels": [],
                "Attributes": {
                    "category": "cloud_ssd",
                    "delete_with_instance": "false",
                    "description": "Test For Terraform",
                    "name": "terraform-example",
                    "size": "40"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 56,
                    "startLine": 50
                }
            },
            {
                "Type": "network_interfaces",
                "Labels": [],
                "Attributes": {
                    "description": "hello1",
                    "name": "eth0",
                    "primary_ip": "10.0.0.2",
                    "security_group_id": "alicloud_security_group.default.id",
                    "vswitch_id": "alicloud_vswitch.default.id"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 74,
                    "startLine": 68
                }
            },
            {
                "Type": "data_disks",
                "Labels": [],
                "Attributes": {
                    "category": "cloud",
                    "delete_with_instance": "true",
                    "description": "description",
                    "encrypted": "false",
                    "name": "disk1",
                    "performance_level": "PL0",
                    "size": "20"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 84,
                    "startLine": 76
                }
            },
            {
                "Type": "data_disks",
                "Labels": [],
                "Attributes": {
                    "category": "cloud",
                    "delete_with_instance": "true",
                    "description": "description2",
                    "encrypted": "true",
                    "name": "disk2",
                    "performance_level": "PL0",
                    "size": "20"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 93,
                    "startLine": 85
                }
            }
        ],
        "line_range": {
            "endLine": 94,
            "startLine": 31
        }
    }]
	count(result) == 1
}

test_alicloud_ecs_launch_template_disks_are_encrypted_failed {
	result := failed with input as [{
        "Type": "data",
        "Labels": [
            "alicloud_zones",
            "default"
        ],
        "Attributes": {
            "available_disk_category": "cloud_efficiency",
            "available_resource_creation": "VSwitch"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 1
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_instance_types",
            "default"
        ],
        "Attributes": {
            "availability_zone": "data.alicloud_zones.default.zones..id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 5
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_images",
            "default"
        ],
        "Attributes": {
            "name_regex": "^ubuntu_[0-9]+_[0-9]+_x64*",
            "owners": "system"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 9
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_vpc",
            "default"
        ],
        "Attributes": {
            "cidr_block": "172.17.3.0/24",
            "vpc_name": "terraform-example"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 14
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_vswitch",
            "default"
        ],
        "Attributes": {
            "cidr_block": "172.17.3.0/24",
            "vpc_id": "alicloud_vpc.default.id",
            "vswitch_name": "terraform-example",
            "zone_id": "data.alicloud_zones.default.zones..id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 24,
            "startLine": 19
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_security_group",
            "default"
        ],
        "Attributes": {
            "name": "terraform-example",
            "vpc_id": "alicloud_vpc.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 29,
            "startLine": 26
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_ecs_launch_template",
            "default"
        ],
        "Attributes": {
            "description": "terraform-example",
            "host_name": "terraform-example",
            "image_id": "data.alicloud_images.default.images..id",
            "instance_charge_type": "PrePaid",
            "instance_name": "terraform-example",
            "instance_type": "data.alicloud_instance_types.default.instance_types..id",
            "internet_charge_type": "PayByBandwidth",
            "internet_max_bandwidth_in": "5",
            "internet_max_bandwidth_out": "5",
            "io_optimized": "optimized",
            "key_pair_name": "key_pair_name",
            "launch_template_name": "terraform-example",
            "network_type": "vpc",
            "ram_role_name": "ram_role_name",
            "security_enhancement_strategy": "Active",
            "security_group_ids": "alicloud_security_group.default.id",
            "spot_price_limit": "5",
            "spot_strategy": "SpotWithPriceLimit",
            "template_tags": {
                "Create": "Terraform",
                "For": "example"
            },
            "user_data": "xxxxxxx",
            "vpc_id": "alicloud_vpc.default.id",
            "vswitch_id": "alicloud_vswitch.default.id",
            "zone_id": "data.alicloud_zones.default.zones..id"
        },
        "Blocks": [
            {
                "Type": "system_disk",
                "Labels": [],
                "Attributes": {
                    "category": "cloud_ssd",
                    "delete_with_instance": "false",
                    "description": "Test For Terraform",
                    "name": "terraform-example",
                    "size": "40"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 56,
                    "startLine": 50
                }
            },
            {
                "Type": "network_interfaces",
                "Labels": [],
                "Attributes": {
                    "description": "hello1",
                    "name": "eth0",
                    "primary_ip": "10.0.0.2",
                    "security_group_id": "alicloud_security_group.default.id",
                    "vswitch_id": "alicloud_vswitch.default.id"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 74,
                    "startLine": 68
                }
            },
            {
                "Type": "data_disks",
                "Labels": [],
                "Attributes": {
                    "category": "cloud",
                    "delete_with_instance": "true",
                    "description": "description",
                    "encrypted": "false",
                    "name": "disk1",
                    "performance_level": "PL0",
                    "size": "20"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 84,
                    "startLine": 76
                }
            },
            {
                "Type": "data_disks",
                "Labels": [],
                "Attributes": {
                    "category": "cloud",
                    "delete_with_instance": "true",
                    "description": "description2",
                    "encrypted": "false",
                    "name": "disk2",
                    "performance_level": "PL0",
                    "size": "20"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 93,
                    "startLine": 85
                }
            }
        ],
        "line_range": {
            "endLine": 94,
            "startLine": 31
        }
    }]
	count(result) == 1
}
