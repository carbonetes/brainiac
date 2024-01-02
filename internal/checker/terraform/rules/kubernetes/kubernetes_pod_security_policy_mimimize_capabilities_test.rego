package lib.terraform.CB_TFK8S_024

test_kubernetes_pod_security_policy_mimimize_capabilities_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "kubernetes_pod_security_policy",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "metadata",
                "Labels": [],
                "Attributes": {
                    "name": "terraform-example"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 4,
                    "startLine": 2
                }
            },
            {
                "Type": "spec",
                "Labels": [],
                "Attributes": {
                    "allow_privilege_escalation": false,
                    "privileged": false,
                    "read_only_root_filesystem": true,
                    "required_drop_capabilities": [
                        "NET_RAW"
                    ],
                    "volumes": [
                        "configMap",
                        "emptyDir",
                        "projected",
                        "secret",
                        "downwardAPI",
                        "persistentVolumeClaim"
                    ]
                },
                "Blocks": [
                    {
                        "Type": "run_as_user",
                        "Labels": [],
                        "Attributes": {
                            "rule": "MustRunAsNonRoot"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 20,
                            "startLine": 18
                        }
                    },
                    {
                        "Type": "se_linux",
                        "Labels": [],
                        "Attributes": {
                            "rule": "RunAsAny"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 24,
                            "startLine": 22
                        }
                    },
                    {
                        "Type": "supplemental_groups",
                        "Labels": [],
                        "Attributes": {
                            "rule": "MustRunAs"
                        },
                        "Blocks": [
                            {
                                "Type": "range",
                                "Labels": [],
                                "Attributes": {
                                    "max": "65535",
                                    "min": "1"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 31,
                                    "startLine": 28
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 32,
                            "startLine": 26
                        }
                    },
                    {
                        "Type": "fs_group",
                        "Labels": [],
                        "Attributes": {
                            "rule": "MustRunAs"
                        },
                        "Blocks": [
                            {
                                "Type": "range",
                                "Labels": [],
                                "Attributes": {
                                    "max": "65535",
                                    "min": "1"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 39,
                                    "startLine": 36
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 40,
                            "startLine": 34
                        }
                    }
                ],
                "line_range": {
                    "endLine": 44,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 45,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_kubernetes_pod_security_policy_mimimize_capabilities_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "kubernetes_pod_security_policy",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "metadata",
                "Labels": [],
                "Attributes": {
                    "name": "terraform-example"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 4,
                    "startLine": 2
                }
            },
            {
                "Type": "spec",
                "Labels": [],
                "Attributes": {
                    "allow_privilege_escalation": false,
                    "privileged": false,
                    "read_only_root_filesystem": true,
                    "volumes": [
                        "configMap",
                        "emptyDir",
                        "projected",
                        "secret",
                        "downwardAPI",
                        "persistentVolumeClaim"
                    ]
                },
                "Blocks": [
                    {
                        "Type": "run_as_user",
                        "Labels": [],
                        "Attributes": {
                            "rule": "MustRunAsNonRoot"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 20,
                            "startLine": 18
                        }
                    },
                    {
                        "Type": "se_linux",
                        "Labels": [],
                        "Attributes": {
                            "rule": "RunAsAny"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 24,
                            "startLine": 22
                        }
                    },
                    {
                        "Type": "supplemental_groups",
                        "Labels": [],
                        "Attributes": {
                            "rule": "MustRunAs"
                        },
                        "Blocks": [
                            {
                                "Type": "range",
                                "Labels": [],
                                "Attributes": {
                                    "max": "65535",
                                    "min": "1"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 31,
                                    "startLine": 28
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 32,
                            "startLine": 26
                        }
                    },
                    {
                        "Type": "fs_group",
                        "Labels": [],
                        "Attributes": {
                            "rule": "MustRunAs"
                        },
                        "Blocks": [
                            {
                                "Type": "range",
                                "Labels": [],
                                "Attributes": {
                                    "max": "65535",
                                    "min": "1"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 39,
                                    "startLine": 36
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 40,
                            "startLine": 34
                        }
                    }
                ],
                "line_range": {
                    "endLine": 44,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 45,
            "startLine": 1
        }
    }]
	count(result) == 1
}