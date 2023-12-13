package lib.terraform.CB_TFALI_041

test_alicloud_mongodb_instance_transpartent_data_encryption_passed {
	result := passed with input as [{
        "Type": "variable",
        "Labels": [
            "name"
        ],
        "Attributes": {
            "default": "terraform-example"
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
            "alicloud_mongodb_zones",
            "default"
        ],
        "Attributes": {},
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 5
        }
    },
    {
        "Type": "locals",
        "Labels": [],
        "Attributes": {
            "zone_id": "data.alicloud_mongodb_zones.default.zones"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 8
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
            "vpc_name": "var.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 16,
            "startLine": 13
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
            "vswitch_name": "var.name",
            "zone_id": "local.zone_id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 23,
            "startLine": 18
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_mongodb_instance",
            "default"
        ],
        "Attributes": {
            "db_instance_class": "dds.mongo.mid",
            "db_instance_storage": "10",
            "engine_version": "4.2",
            "name": "var.name",
            "security_ip_list": [
                "10.168.1.12",
                "100.69.7.112"
            ],
            "ssl_action": "Update",
            "tags": {
                "Created": "TF",
                "For": "example"
            },
            "tde_status": "enabled",
            "vswitch_id": "alicloud_vswitch.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 38,
            "startLine": 25
        }
    }]
	count(result) == 1
}

test_alicloud_mongodb_instance_transpartent_data_encryption_failed {
	result := failed with input as [{
        "Type": "variable",
        "Labels": [
            "name"
        ],
        "Attributes": {
            "default": "terraform-example"
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
            "alicloud_mongodb_zones",
            "default"
        ],
        "Attributes": {},
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 5
        }
    },
    {
        "Type": "locals",
        "Labels": [],
        "Attributes": {
            "zone_id": "data.alicloud_mongodb_zones.default.zones"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 8
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
            "vpc_name": "var.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 16,
            "startLine": 13
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
            "vswitch_name": "var.name",
            "zone_id": "local.zone_id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 23,
            "startLine": 18
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_mongodb_instance",
            "default"
        ],
        "Attributes": {
            "db_instance_class": "dds.mongo.mid",
            "db_instance_storage": "10",
            "engine_version": "4.2",
            "name": "var.name",
            "security_ip_list": [
                "10.168.1.12",
                "100.69.7.112"
            ],
            "ssl_action": "Close",
            "tags": {
                "Created": "TF",
                "For": "example"
            },
            "vswitch_id": "alicloud_vswitch.default.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 37,
            "startLine": 25
        }
    }]
	count(result) == 1
}
