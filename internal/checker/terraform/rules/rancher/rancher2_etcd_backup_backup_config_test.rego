package lib.terraform.CB_TFRAN_123

test_rancher2_etcd_backup_backup_config_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_etcd_backup",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "<CLUSTER_ID>",
            "filename": "<FILENAME>",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "backup_config",
                "Labels": [],
                "Attributes": {
                    "enabled": true,
                    "interval_hours": "20",
                    "retention": "10"
                },
                "Blocks": [
                    {
                        "Type": "s3_backup_config",
                        "Labels": [],
                        "Attributes": {
                            "access_key": "access_key",
                            "bucket_name": "bucket_name",
                            "endpoint": "endpoint",
                            "folder": "/folder",
                            "region": "region",
                            "secret_key": "secret_key"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 14,
                            "startLine": 7
                        }
                    }
                ],
                "line_range": {
                    "endLine": 15,
                    "startLine": 3
                }
            }
        ],
        "line_range": {
            "endLine": 19,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_etcd_backup_backup_config_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_etcd_backup",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "<CLUSTER_ID>",
            "filename": "<FILENAME>",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "not_backup_config",
                "Labels": [],
                "Attributes": {
                    "enabled": false,
                    "interval_hours": "20",
                    "retention": "10"
                },
                "Blocks": [
                    {
                        "Type": "s3_backup_config",
                        "Labels": [],
                        "Attributes": {
                            "access_key": "access_key",
                            "bucket_name": "bucket_name",
                            "endpoint": "endpoint",
                            "folder": "/folder",
                            "region": "region",
                            "secret_key": "secret_key"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 14,
                            "startLine": 7
                        }
                    }
                ],
                "line_range": {
                    "endLine": 15,
                    "startLine": 3
                }
            }
        ],
        "line_range": {
            "endLine": 19,
            "startLine": 2
        }
    }]
    count(result) == 1
}