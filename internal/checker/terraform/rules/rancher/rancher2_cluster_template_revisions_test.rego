package lib.terraform.CB_TFRAN_121

test_rancher2_cluster_template_revisions_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_template",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform cluster template foo",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "members",
                "Labels": [],
                "Attributes": {
                    "access_type": "owner",
                    "user_principal_id": "local://user-XXXXX"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 4
                }
            },
            {
                "Type": "template_revisions",
                "Labels": [],
                "Attributes": {
                    "default": true,
                    "name": "V1"
                },
                "Blocks": [
                    {
                        "Type": "cluster_config",
                        "Labels": [],
                        "Attributes": {},
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
                                            "endLine": 14,
                                            "startLine": 12
                                        }
                                    },
                                    {
                                        "Type": "services",
                                        "Labels": [],
                                        "Attributes": {},
                                        "Blocks": [
                                            {
                                                "Type": "etcd",
                                                "Labels": [],
                                                "Attributes": {
                                                    "creation": "6h",
                                                    "retention": "24h"
                                                },
                                                "Blocks": [],
                                                "line_range": {
                                                    "endLine": 19,
                                                    "startLine": 16
                                                }
                                            }
                                        ],
                                        "line_range": {
                                            "endLine": 20,
                                            "startLine": 15
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
                    "endLine": 24,
                    "startLine": 8
                }
            }
        ],
        "line_range": {
            "endLine": 26,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_template_revisions_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_template",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform cluster template foo",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "members",
                "Labels": [],
                "Attributes": {
                    "access_type": "owner",
                    "user_principal_id": "local://user-XXXXX"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 4
                }
            },
            {
                "Type": "template_revisions",
                "Labels": [],
                "Attributes": {
                    "default": true,
                    "name": ""
                },
                "Blocks": [
                    {
                        "Type": "cluster_config2",
                        "Labels": [],
                        "Attributes": {},
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
                                            "endLine": 14,
                                            "startLine": 12
                                        }
                                    },
                                    {
                                        "Type": "services",
                                        "Labels": [],
                                        "Attributes": {},
                                        "Blocks": [
                                            {
                                                "Type": "etcd",
                                                "Labels": [],
                                                "Attributes": {
                                                    "creation": "6h",
                                                    "retention": "24h"
                                                },
                                                "Blocks": [],
                                                "line_range": {
                                                    "endLine": 19,
                                                    "startLine": 16
                                                }
                                            }
                                        ],
                                        "line_range": {
                                            "endLine": 20,
                                            "startLine": 15
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
                    "endLine": 24,
                    "startLine": 8
                }
            }
        ],
        "line_range": {
            "endLine": 26,
            "startLine": 2
        }
    }]
    count(result) == 1
}