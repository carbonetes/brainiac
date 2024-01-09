package lib.terraform.CB_TFYC_010

test_yandex_kubernetes_cluster_kms_key_is_set_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_kubernetes_cluster",
            "zonal_cluster_resource_name"
        ],
        "Attributes": {
            "description": "description",
            "labels": {
                "my_key": "my_value",
                "my_other_key": "my_other_value"
            },
            "name": "name",
            "network_id": "yandex_vpc_network.network_resource_name.id",
            "network_policy_provider": "CALICO",
            "node_service_account_id": "yandex_iam_service_account.node_service_account_resource_name.id",
            "release_channel": "RAPID",
            "service_account_id": "yandex_iam_service_account.service_account_resource_name.id"
        },
        "Blocks": [
            {
                "Type": "master",
                "Labels": [],
                "Attributes": {
                    "public_ip": true,
                    "security_group_ids": "yandex_vpc_security_group.security_group_name.id",
                    "version": "1.17"
                },
                "Blocks": [
                    {
                        "Type": "zonal",
                        "Labels": [],
                        "Attributes": {
                            "subnet_id": "yandex_vpc_subnet.subnet_resource_name.id",
                            "zone": "yandex_vpc_subnet.subnet_resource_name.zone"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 12,
                            "startLine": 9
                        }
                    },
                    {
                        "Type": "maintenance_policy",
                        "Labels": [],
                        "Attributes": {
                            "auto_upgrade": true
                        },
                        "Blocks": [
                            {
                                "Type": "maintenance_window",
                                "Labels": [],
                                "Attributes": {
                                    "duration": "3h",
                                    "start_time": "15:00"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 24,
                                    "startLine": 21
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 25,
                            "startLine": 18
                        }
                    }
                ],
                "line_range": {
                    "endLine": 26,
                    "startLine": 7
                }
            },
            {
                "Type": "kms_provider",
                "Labels": [],
                "Attributes": {
                    "key_id": "yandex_kms_symmetric_key.kms_key_resource_name.id"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 41,
                    "startLine": 39
                }
            }
        ],
        "line_range": {
            "endLine": 42,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_yandex_kubernetes_cluster_kms_key_is_set_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_kubernetes_cluster",
            "zonal_cluster_resource_name"
        ],
        "Attributes": {
            "description": "description",
            "labels": {
                "my_key": "my_value",
                "my_other_key": "my_other_value"
            },
            "name": "name",
            "network_id": "yandex_vpc_network.network_resource_name.id",
            "network_policy_provider": "CALICO",
            "node_service_account_id": "yandex_iam_service_account.node_service_account_resource_name.id",
            "release_channel": "RAPID",
            "service_account_id": "yandex_iam_service_account.service_account_resource_name.id"
        },
        "Blocks": [
            {
                "Type": "master",
                "Labels": [],
                "Attributes": {
                    "public_ip": true,
                    "security_group_ids": "yandex_vpc_security_group.security_group_name.id",
                    "version": "1.17"
                },
                "Blocks": [
                    {
                        "Type": "zonal",
                        "Labels": [],
                        "Attributes": {
                            "subnet_id": "yandex_vpc_subnet.subnet_resource_name.id",
                            "zone": "yandex_vpc_subnet.subnet_resource_name.zone"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 12,
                            "startLine": 9
                        }
                    },
                    {
                        "Type": "maintenance_policy",
                        "Labels": [],
                        "Attributes": {
                            "auto_upgrade": true
                        },
                        "Blocks": [
                            {
                                "Type": "maintenance_window",
                                "Labels": [],
                                "Attributes": {
                                    "duration": "3h",
                                    "start_time": "15:00"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 24,
                                    "startLine": 21
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 25,
                            "startLine": 18
                        }
                    }
                ],
                "line_range": {
                    "endLine": 26,
                    "startLine": 7
                }
            }
        ],
        "line_range": {
            "endLine": 42,
            "startLine": 1
        }
    }]
	count(result) == 1
}