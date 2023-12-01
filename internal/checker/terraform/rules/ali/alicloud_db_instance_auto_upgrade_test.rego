package lib.terraform.CB_TFALI_021

test_alicloud_db_instance_auto_upgrade_passed {
	result := passed with input as [{
        "Type": "data",
        "Labels": [
            "alicloud_db_zones",
            "example"
        ],
        "Attributes": {
            "category": "Basic",
            "db_instance_storage_type": "cloud_essd",
            "engine": "MySQL",
            "engine_version": "8.0",
            "instance_charge_type": "PostPaid"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_db_instance_classes",
            "example"
        ],
        "Attributes": {
            "category": "Basic",
            "db_instance_storage_type": "cloud_essd",
            "engine": "MySQL",
            "engine_version": "8.0",
            "instance_charge_type": "PostPaid",
            "zone_id": "data.alicloud_db_zones.example.zones..id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 16,
            "startLine": 9
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_vpc",
            "example"
        ],
        "Attributes": {
            "cidr_block": "172.16.0.0/16",
            "vpc_name": "terraform-example"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 21,
            "startLine": 18
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_vswitch",
            "example"
        ],
        "Attributes": {
            "cidr_block": "172.16.0.0/24",
            "vpc_id": "alicloud_vpc.example.id",
            "vswitch_name": "terraform-example",
            "zone_id": "data.alicloud_db_zones.example.zones..id"
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
            "alicloud_security_group",
            "example"
        ],
        "Attributes": {
            "name": "terraform-example",
            "vpc_id": "alicloud_vpc.example.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 33,
            "startLine": 30
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_db_instance",
            "example"
        ],
        "Attributes": {
            "auto_upgrade_minor_version": "Auto",
            "db_instance_storage_type": "cloud_essd",
            "engine": "MySQL",
            "engine_version": "8.0",
            "instance_charge_type": "Postpaid",
            "instance_name": "terraform-example",
            "instance_storage": "data.alicloud_db_instance_classes.example.instance_classes..storage_range.min",
            "instance_type": "data.alicloud_db_instance_classes.example.instance_classes..instance_class",
            "monitoring_period": "60",
            "security_group_ids": "alicloud_security_group.example.id",
            "vswitch_id": "alicloud_vswitch.example.id"
        },
        "Blocks": [
            {
                "Type": "parameters",
                "Labels": [],
                "Attributes": {
                    "name": "delayed_insert_timeout",
                    "value": "600"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 50,
                    "startLine": 47
                }
            },
            {
                "Type": "parameters",
                "Labels": [],
                "Attributes": {
                    "name": "max_length_for_sort_data",
                    "value": "2048"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 54,
                    "startLine": 51
                }
            }
        ],
        "line_range": {
            "endLine": 55,
            "startLine": 35
        }
    }]
	count(result) == 1
}

test_alicloud_db_instance_auto_upgrade_failed {
	result := failed with input as [{
        "Type": "data",
        "Labels": [
            "alicloud_db_zones",
            "example"
        ],
        "Attributes": {
            "category": "Basic",
            "db_instance_storage_type": "cloud_essd",
            "engine": "MySQL",
            "engine_version": "8.0",
            "instance_charge_type": "PostPaid"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_db_instance_classes",
            "example"
        ],
        "Attributes": {
            "category": "Basic",
            "db_instance_storage_type": "cloud_essd",
            "engine": "MySQL",
            "engine_version": "8.0",
            "instance_charge_type": "PostPaid",
            "zone_id": "data.alicloud_db_zones.example.zones..id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 16,
            "startLine": 9
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_vpc",
            "example"
        ],
        "Attributes": {
            "cidr_block": "172.16.0.0/16",
            "vpc_name": "terraform-example"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 21,
            "startLine": 18
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_vswitch",
            "example"
        ],
        "Attributes": {
            "cidr_block": "172.16.0.0/24",
            "vpc_id": "alicloud_vpc.example.id",
            "vswitch_name": "terraform-example",
            "zone_id": "data.alicloud_db_zones.example.zones..id"
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
            "alicloud_security_group",
            "example"
        ],
        "Attributes": {
            "name": "terraform-example",
            "vpc_id": "alicloud_vpc.example.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 33,
            "startLine": 30
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_db_instance",
            "example"
        ],
        "Attributes": {
            "auto_upgrade_minor_version": "Manual",
            "db_instance_storage_type": "cloud_essd",
            "engine": "MySQL",
            "engine_version": "8.0",
            "instance_charge_type": "Postpaid",
            "instance_name": "terraform-example",
            "instance_storage": "data.alicloud_db_instance_classes.example.instance_classes..storage_range.min",
            "instance_type": "data.alicloud_db_instance_classes.example.instance_classes..instance_class",
            "monitoring_period": "60",
            "security_group_ids": "alicloud_security_group.example.id",
            "vswitch_id": "alicloud_vswitch.example.id"
        },
        "Blocks": [
            {
                "Type": "parameters",
                "Labels": [],
                "Attributes": {
                    "name": "delayed_insert_timeout",
                    "value": "600"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 50,
                    "startLine": 47
                }
            },
            {
                "Type": "parameters",
                "Labels": [],
                "Attributes": {
                    "name": "max_length_for_sort_data",
                    "value": "2048"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 54,
                    "startLine": 51
                }
            }
        ],
        "line_range": {
            "endLine": 55,
            "startLine": 35
        }
    }]
	count(result) == 1
}