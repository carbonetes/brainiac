package lib.terraform.CB_TFALI_033

test_alicloud_db_instance_logs_enabled_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "alicloud"
        ],
        "Attributes": {
            "access_key": "your-access-key",
            "region": "cn-beijing",
            "secret_key": "your-secret-key"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_db_instance",
            "example"
        ],
        "Attributes": {
            "category": "high_availability",
            "db_instance_storage_type": "cloud_efficiency",
            "engine": "mysql",
            "engine_version": "5.7",
            "instance_class": "rds.mysql.s1.small",
            "instance_storage": "100",
            "log_backup_local_retention_hours": "24",
            "log_backup_retention_period": "7",
            "name": "example-db",
            "password": "password",
            "security_ips": [
                "0.0.0.0/0"
            ],
            "vswitch_id": "your-vswitch-id"
        },
        "Blocks": [
            {
                "Type": "parameter",
                "Labels": [],
                "Attributes": {
                    "name": "log_duration",
                    "value": "4320"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 27,
                    "startLine": 24
                }
            }
        ],
        "line_range": {
            "endLine": 28,
            "startLine": 7
        }
    }]
	count(result) == 1
}

test_alicloud_db_instance_logs_enabled_failed {
	result := failed with input as [{
        "Type": "provider",
        "Labels": [
            "alicloud"
        ],
        "Attributes": {
            "access_key": "your-access-key",
            "region": "cn-beijing",
            "secret_key": "your-secret-key"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_db_instance",
            "example"
        ],
        "Attributes": {
            "category": "high_availability",
            "db_instance_storage_type": "cloud_efficiency",
            "engine": "mysql",
            "engine_version": "5.7",
            "instance_class": "rds.mysql.s1.small",
            "instance_storage": "100",
            "log_backup_local_retention_hours": "24",
            "log_backup_retention_period": "7",
            "name": "example-db",
            "password": "password",
            "security_ips": [
                "0.0.0.0/0"
            ],
            "vswitch_id": "your-vswitch-id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 28,
            "startLine": 7
        }
    }]
	count(result) == 1
}