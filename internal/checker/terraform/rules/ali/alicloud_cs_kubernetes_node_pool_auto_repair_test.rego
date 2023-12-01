package lib.terraform.CB_TFALI_022

test_alicloud_cs_kubernetes_node_pool_auto_repair_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "alicloud"
        ],
        "Attributes": {
            "access_key": "your-access-key",
            "region": "your-region",
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
            "alicloud_cs_kubernetes_node_pool",
            "example"
        ],
        "Attributes": {
            "name": "example-cluster",
            "region_id": "your-region",
            "vpc_id": "your-vpc-id"
        },
        "Blocks": [
            {
                "Type": "management",
                "Labels": [],
                "Attributes": {
                    "auto_repair": true,
                    "instance_type": "ecs.n4.small",
                    "key_pair": "your-key-pair",
                    "name": "example-node-pool",
                    "system_disk_size": "100"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 18,
            "startLine": 7
        }
    }]
	count(result) == 1
}

test_alicloud_cs_kubernetes_node_pool_auto_repair_failed {
	result := failed with input as [{
        "Type": "provider",
        "Labels": [
            "alicloud"
        ],
        "Attributes": {
            "access_key": "your-access-key",
            "region": "your-region",
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
            "alicloud_cs_kubernetes_node_pool",
            "example"
        ],
        "Attributes": {
            "name": "example-cluster",
            "region_id": "your-region",
            "vpc_id": "your-vpc-id"
        },
        "Blocks": [
            {
                "Type": "management",
                "Labels": [],
                "Attributes": {
                    "auto_repair": false,
                    "instance_type": "ecs.n4.small",
                    "key_pair": "your-key-pair",
                    "name": "example-node-pool",
                    "system_disk_size": "100"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 18,
            "startLine": 7
        }
    }]
	count(result) == 1
}