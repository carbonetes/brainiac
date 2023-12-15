package lib.terraform.CB_TFALI_011

test_alicloud_cs_kubernetes_enable_network_policies_passed {
	result := passed with input as [{
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
            "alicloud_resource_manager_resource_groups",
            "default"
        ],
        "Attributes": {
            "status": "OK"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
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
            "availability_zone": "data.alicloud_zones.default.zones",
            "count": "3",
            "cpu_core_count": "4",
            "kubernetes_node_role": "Master",
            "memory_size": "8",
            "system_disk_category": "cloud_essd"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 18,
            "startLine": 11
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
            "endLine": 23,
            "startLine": 20
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_vswitch",
            "default"
        ],
        "Attributes": {
            "count": "3",
            "vpc_id": "alicloud_vpc.default.id",
            "zone_id": "data.alicloud_zones.default.zones"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 30,
            "startLine": 24
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes",
            "default"
        ],
        "Attributes": {
            "cluster_domain": "cluster.local",
            "custom_san": "www.terraform.io",
            "deletion_protection": "false",
            "install_cloud_monitor": "true",
            "load_balancer_spec": "slb.s2.small",
            "master_disk_category": "cloud_essd",
            "master_instance_types": "data.alicloud_instance_types.default..instance_types..id",
            "master_vswitch_ids": "alicloud_vswitch.default",
            "new_nat_gateway": "true",
            "os_type": "Linux",
            "password": "Yourpassword1234",
            "platform": "CentOS",
            "pod_cidr": "10.72.0.0/16",
            "proxy_mode": "ipvs",
            "resource_group_id": "data.alicloud_resource_manager_resource_groups.default.groups..id",
            "service_cidr": "172.18.0.0/16",
            "timezone": "Asia/Shanghai",
            "version": "1.24.6-aliyun.1"
        },
        "Blocks": [
            {
                "Type": "addons",
                "Labels": [],
                "Attributes": {
                    "config": "{\"IngressSlbNetworkType\":\"internet",
                    "name": "nginx-ingress-controller"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 55,
                    "startLine": 52
                }
            }
        ],
        "line_range": {
            "endLine": 56,
            "startLine": 32
        }
    }]
	count(result) == 1
}

test_alicloud_cs_kubernetes_enable_network_policies_failed {
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
            "alicloud_resource_manager_resource_groups",
            "default"
        ],
        "Attributes": {
            "status": "OK"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
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
            "availability_zone": "data.alicloud_zones.default.zones",
            "count": "3",
            "cpu_core_count": "4",
            "kubernetes_node_role": "Master",
            "memory_size": "8",
            "system_disk_category": "cloud_essd"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 18,
            "startLine": 11
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
            "endLine": 23,
            "startLine": 20
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_vswitch",
            "default"
        ],
        "Attributes": {
            "count": "3",
            "vpc_id": "alicloud_vpc.default.id",
            "zone_id": "data.alicloud_zones.default.zones"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 30,
            "startLine": 24
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_cs_kubernetes",
            "default"
        ],
        "Attributes": {
            "cluster_domain": "cluster.local",
            "custom_san": "www.terraform.io",
            "deletion_protection": "false",
            "install_cloud_monitor": "true",
            "load_balancer_spec": "slb.s2.small",
            "master_disk_category": "cloud_essd",
            "master_instance_types": "data.alicloud_instance_types.default..instance_types..id",
            "master_vswitch_ids": "alicloud_vswitch.default",
            "new_nat_gateway": "true",
            "os_type": "Linux",
            "password": "Yourpassword1234",
            "platform": "CentOS",
            "proxy_mode": "ipvs",
            "resource_group_id": "data.alicloud_resource_manager_resource_groups.default.groups..id",
            "service_cidr": "172.18.0.0/16",
            "timezone": "Asia/Shanghai",
            "version": "1.24.6-aliyun.1"
        },
        "Blocks": [
            {
                "Type": "addons",
                "Labels": [],
                "Attributes": {
                    "config": "{\"IngressSlbNetworkType\":\"internet",
                    "name": "nginx-ingress-controller"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 55,
                    "startLine": 52
                }
            }
        ],
        "line_range": {
            "endLine": 56,
            "startLine": 32
        }
    }]
	count(result) == 1
}
