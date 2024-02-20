package lib.terraform.CB_TFRAN_059

test_rancher2_cluster_rke_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster",
            "foo-custom"
        ],
        "Attributes": {
            "description": "Foo rancher2 custom cluster",
            "name": "foo-custom"
        },
        "Blocks": [
            {
                "Type": "rke_config",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "network",
                        "Labels": [],
                        "Attributes": {
                            "plugin": "canal"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 8,
                            "startLine": 6
                        }
                    },
                    {
                        "Type": "services",
                        "Labels": [],
                        "Attributes": {},
                        "Blocks": [
                            {
                                "Type": "kube_api",
                                "Labels": [],
                                "Attributes": {},
                                "Blocks": [
                                    {
                                        "Type": "audit_log",
                                        "Labels": [],
                                        "Attributes": {
                                            "enabled": true
                                        },
                                        "Blocks": [
                                            {
                                                "Type": "configuration",
                                                "Labels": [],
                                                "Attributes": {
                                                    "format": "json",
                                                    "max_age": "5",
                                                    "max_backup": "5",
                                                    "max_size": "100",
                                                    "path": "-"
                                                },
                                                "Blocks": [],
                                                "line_range": {
                                                    "endLine": 20,
                                                    "startLine": 13
                                                }
                                            }
                                        ],
                                        "line_range": {
                                            "endLine": 21,
                                            "startLine": 11
                                        }
                                    }
                                ],
                                "line_range": {
                                    "endLine": 22,
                                    "startLine": 10
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 23,
                            "startLine": 9
                        }
                    }
                ],
                "line_range": {
                    "endLine": 24,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 25,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_rke_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster",
            "foo-custom"
        ],
        "Attributes": {
            "description": "Foo rancher2 custom cluster",
            "name": "foo-custom"
        },
        "Blocks": [
            {
                "Type": "rke_config",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "network",
                        "Labels": [],
                        "Attributes": {
                            "plugin": "canal"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 8,
                            "startLine": 6
                        }
                    },
                    {
                        "Type": "services",
                        "Labels": [],
                        "Attributes": {},
                        "Blocks": [
                            {
                                "Type": "kube_api",
                                "Labels": [],
                                "Attributes": {},
                                "Blocks": [
                                    {
                                        "Type": "audit_log",
                                        "Labels": [],
                                        "Attributes": {
                                            "enabled": true
                                        },
                                        "Blocks": [
                                            {
                                                "Type": "configuration",
                                                "Labels": [],
                                                "Attributes": {
                                                    "format": "json",
                                                    "max_age": "5",
                                                    "max_backup": "5",
                                                    "max_size": "100",
                                                    "path": "-"
                                                },
                                                "Blocks": [],
                                                "line_range": {
                                                    "endLine": 20,
                                                    "startLine": 13
                                                }
                                            }
                                        ],
                                        "line_range": {
                                            "endLine": 21,
                                            "startLine": 11
                                        }
                                    }
                                ],
                                "line_range": {
                                    "endLine": 22,
                                    "startLine": 10
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 23,
                            "startLine": 9
                        }
                    }
                ],
                "line_range": {
                    "endLine": 24,
                    "startLine": 5
                }
            },
            {
                "Type": "aks_config_v2",
                "Labels": [],
                "Attributes": {
                    "cloud_credential_id": "rancher2_cloud_credential.foo-aks.id",
                    "imported": true,
                    "resource_group": "<RESOURCE_GROUP>",
                    "resource_location": "<RESOURCE_LOCATION>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 30,
                    "startLine": 25
                }
            }
        ],
        "line_range": {
            "endLine": 31,
            "startLine": 2
        }
    }]
    count(result) == 1
}