package lib.terraform.CB_TFALI_010

test_alicloud_db_instance_rds_retention_passed {
	result := passed with input as [{
        "Type": "variable",
        "Labels": [
            "name"
        ],
        "Attributes": {
            "default": "tf-accdbinstance"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "provider",
        "Labels": [
            "alicloud"
        ],
        "Attributes": {
            "region": "cn-hangzhou"
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
            "alicloud_db_zones",
            "example"
        ],
        "Attributes": {
            "category": "serverless_ha",
            "db_instance_storage_type": "cloud_essd",
            "engine": "SQLServer",
            "engine_version": "2019_std_sl",
            "instance_charge_type": "Serverless"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 8
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_db_instance_classes",
            "example"
        ],
        "Attributes": {
            "category": "serverless_ha",
            "commodity_code": "rds_serverless_public_cn",
            "db_instance_storage_type": "cloud_essd",
            "engine": "SQLServer",
            "engine_version": "2019_std_sl",
            "instance_charge_type": "Serverless",
            "zone_id": "data.alicloud_db_zones.example.ids."
        },
        "Blocks": [],
        "line_range": {
            "endLine": 24,
            "startLine": 16
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
            "vpc_name": "var.name"
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
            "alicloud_vswitch",
            "example"
        ],
        "Attributes": {
            "cidr_block": "172.16.0.0/24",
            "vpc_id": "alicloud_vpc.example.id",
            "vswitch_name": "var.name",
            "zone_id": "data.alicloud_db_zones.example.ids."
        },
        "Blocks": [],
        "line_range": {
            "endLine": 36,
            "startLine": 31
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_db_instance",
            "example"
        ],
        "Attributes": {
            "category": "serverless_ha",
            "db_instance_storage_type": "cloud_essd",
            "engine": "SQLServer",
            "engine_version": "2019_std_sl",
            "instance_charge_type": "Serverless",
            "instance_name": "var.name",
            "instance_storage": "data.alicloud_db_instance_classes.example.instance_classes..storage_range.min",
            "instance_type": "data.alicloud_db_instance_classes.example.instance_classes..instance_class",
            "sql_collector_config_value": "180",
            "sql_collector_status": "Disabled",
            "zone_id": "data.alicloud_db_zones.example.ids.",
            "zone_id_slave_a": "data.alicloud_db_zones.example.ids."
        },
        "Blocks": [
            {
                "Type": "serverless_config",
                "Labels": [],
                "Attributes": {
                    "max_capacity": "8",
                    "min_capacity": "2"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 53,
                    "startLine": 50
                }
            }
        ],
        "line_range": {
            "endLine": 56,
            "startLine": 38
        }
    }]
	count(result) == 1
}

test_alicloud_db_instance_rds_retention_failed {
	result := failed with input as [{
        "Type": "variable",
        "Labels": [
            "name"
        ],
        "Attributes": {
            "default": "tf-accdbinstance"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "provider",
        "Labels": [
            "alicloud"
        ],
        "Attributes": {
            "region": "cn-hangzhou"
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
            "alicloud_db_zones",
            "example"
        ],
        "Attributes": {
            "category": "serverless_ha",
            "db_instance_storage_type": "cloud_essd",
            "engine": "SQLServer",
            "engine_version": "2019_std_sl",
            "instance_charge_type": "Serverless"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 8
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_db_instance_classes",
            "example"
        ],
        "Attributes": {
            "category": "serverless_ha",
            "commodity_code": "rds_serverless_public_cn",
            "db_instance_storage_type": "cloud_essd",
            "engine": "SQLServer",
            "engine_version": "2019_std_sl",
            "instance_charge_type": "Serverless",
            "zone_id": "data.alicloud_db_zones.example.ids."
        },
        "Blocks": [],
        "line_range": {
            "endLine": 24,
            "startLine": 16
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
            "vpc_name": "var.name"
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
            "alicloud_vswitch",
            "example"
        ],
        "Attributes": {
            "cidr_block": "172.16.0.0/24",
            "vpc_id": "alicloud_vpc.example.id",
            "vswitch_name": "var.name",
            "zone_id": "data.alicloud_db_zones.example.ids."
        },
        "Blocks": [],
        "line_range": {
            "endLine": 36,
            "startLine": 31
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_db_instance",
            "example"
        ],
        "Attributes": {
            "category": "serverless_ha",
            "db_instance_storage_type": "cloud_essd",
            "engine": "SQLServer",
            "engine_version": "2019_std_sl",
            "instance_charge_type": "Serverless",
            "instance_name": "var.name",
            "instance_storage": "data.alicloud_db_instance_classes.example.instance_classes..storage_range.min",
            "instance_type": "data.alicloud_db_instance_classes.example.instance_classes..instance_class",
            "sql_collector_config_value": "80",
            "sql_collector_status": "Enabled",
            "zone_id": "data.alicloud_db_zones.example.ids.",
            "zone_id_slave_a": "data.alicloud_db_zones.example.ids."
        },
        "Blocks": [
            {
                "Type": "serverless_config",
                "Labels": [],
                "Attributes": {
                    "max_capacity": "8",
                    "min_capacity": "2"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 53,
                    "startLine": 50
                }
            }
        ],
        "line_range": {
            "endLine": 56,
            "startLine": 38
        }
    }]
	count(result) == 1
}
