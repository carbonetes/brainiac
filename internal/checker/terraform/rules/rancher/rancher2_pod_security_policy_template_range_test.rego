package lib.terraform.CB_TFRAN_167

test_rancher2_pod_security_policy_template_range_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_pod_security_policy_template",
            "foo"
        ],
        "Attributes": {
            "allow_privilege_escalation": false,
            "allowed_proc_mount_types": [
                "Default"
            ],
            "default_allow_privilege_escalation": false,
            "description": "Terraform PodSecurityPolicyTemplate acceptance test - update",
            "host_ipc": false,
            "host_network": false,
            "host_pid": false,
            "name": "foo",
            "privileged": false,
            "read_only_root_filesystem": false,
            "required_drop_capabilities": [
                "something"
            ],
            "volumes": [
                "azureFile"
            ]
        },
        "Blocks": [
            {
                "Type": "allowed_csi_driver",
                "Labels": [],
                "Attributes": {
                    "name": "something"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 8,
                    "startLine": 6
                }
            },
            {
                "Type": "allowed_csi_driver",
                "Labels": [],
                "Attributes": {
                    "name": "something-else"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 9
                }
            },
            {
                "Type": "allowed_flex_volume",
                "Labels": [],
                "Attributes": {
                    "driver": "something"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 12
                }
            },
            {
                "Type": "allowed_flex_volume",
                "Labels": [],
                "Attributes": {
                    "driver": "something-else"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 15
                }
            },
            {
                "Type": "allowed_host_path",
                "Labels": [],
                "Attributes": {
                    "path_prefix": "/",
                    "read_only": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 21,
                    "startLine": 18
                }
            },
            {
                "Type": "allowed_host_path",
                "Labels": [],
                "Attributes": {
                    "path_prefix": "//",
                    "read_only": false
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 25,
                    "startLine": 22
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
                            "max": "100",
                            "min": "0"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 33,
                            "startLine": 30
                        }
                    },
                    {
                        "Type": "range",
                        "Labels": [],
                        "Attributes": {
                            "max": "100",
                            "min": "0"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 37,
                            "startLine": 34
                        }
                    }
                ],
                "line_range": {
                    "endLine": 38,
                    "startLine": 28
                }
            },
            {
                "Type": "host_port",
                "Labels": [],
                "Attributes": {
                    "max": "65535",
                    "min": "0"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 45,
                    "startLine": 42
                }
            },
            {
                "Type": "host_port",
                "Labels": [],
                "Attributes": {
                    "max": "8080",
                    "min": "1024"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 49,
                    "startLine": 46
                }
            },
            {
                "Type": "run_as_user",
                "Labels": [],
                "Attributes": {
                    "rule": "MustRunAs"
                },
                "Blocks": [
                    {
                        "Type": "range",
                        "Labels": [],
                        "Attributes": {
                            "max": "100",
                            "min": "1"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 59,
                            "startLine": 56
                        }
                    },
                    {
                        "Type": "range",
                        "Labels": [],
                        "Attributes": {
                            "max": "1024",
                            "min": "2"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 63,
                            "startLine": 60
                        }
                    }
                ],
                "line_range": {
                    "endLine": 64,
                    "startLine": 54
                }
            },
            {
                "Type": "run_as_group",
                "Labels": [],
                "Attributes": {
                    "rule": "MustRunAs"
                },
                "Blocks": [
                    {
                        "Type": "range",
                        "Labels": [],
                        "Attributes": {
                            "max": "100",
                            "min": "1"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 70,
                            "startLine": 67
                        }
                    },
                    {
                        "Type": "range",
                        "Labels": [],
                        "Attributes": {
                            "max": "1024",
                            "min": "2"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 74,
                            "startLine": 71
                        }
                    }
                ],
                "line_range": {
                    "endLine": 75,
                    "startLine": 65
                }
            },
            {
                "Type": "runtime_class",
                "Labels": [],
                "Attributes": {
                    "allowed_runtime_class_names": [
                        "something"
                    ],
                    "default_runtime_class_name": "something"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 79,
                    "startLine": 76
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
                    "endLine": 82,
                    "startLine": 80
                }
            },
            {
                "Type": "supplemental_group",
                "Labels": [],
                "Attributes": {
                    "rule": "RunAsAny"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 85,
                    "startLine": 83
                }
            }
        ],
        "line_range": {
            "endLine": 87,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_pod_security_policy_template_range_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_pod_security_policy_template",
            "foo"
        ],
        "Attributes": {
            "allow_privilege_escalation": false,
            "allowed_proc_mount_types": [
                "Default"
            ],
            "default_allow_privilege_escalation": false,
            "description": "Terraform PodSecurityPolicyTemplate acceptance test - update",
            "host_ipc": false,
            "host_network": false,
            "host_pid": false,
            "name": "foo",
            "privileged": false,
            "read_only_root_filesystem": false,
            "required_drop_capabilities": [
                "something"
            ],
            "volumes": [
                "azureFile"
            ]
        },
        "Blocks": [
            {
                "Type": "allowed_csi_driver",
                "Labels": [],
                "Attributes": {
                    "name": "something"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 8,
                    "startLine": 6
                }
            },
            {
                "Type": "allowed_csi_driver",
                "Labels": [],
                "Attributes": {
                    "name": "something-else"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 9
                }
            },
            {
                "Type": "allowed_flex_volume",
                "Labels": [],
                "Attributes": {
                    "driver": "something"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 12
                }
            },
            {
                "Type": "allowed_flex_volume",
                "Labels": [],
                "Attributes": {
                    "driver": "something-else"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 15
                }
            },
            {
                "Type": "allowed_host_path",
                "Labels": [],
                "Attributes": {
                    "path_prefix": "/",
                    "read_only": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 21,
                    "startLine": 18
                }
            },
            {
                "Type": "allowed_host_path",
                "Labels": [],
                "Attributes": {
                    "path_prefix": "//",
                    "read_only": false
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 25,
                    "startLine": 22
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
                            "max": "",
                            "min": ""
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 33,
                            "startLine": 30
                        }
                    },
                    {
                        "Type": "range",
                        "Labels": [],
                        "Attributes": {
                            "max": "",
                            "min": ""
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 37,
                            "startLine": 34
                        }
                    }
                ],
                "line_range": {
                    "endLine": 38,
                    "startLine": 28
                }
            },
            {
                "Type": "host_port",
                "Labels": [],
                "Attributes": {
                    "max": "65535",
                    "min": "0"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 45,
                    "startLine": 42
                }
            },
            {
                "Type": "host_port",
                "Labels": [],
                "Attributes": {
                    "max": "8080",
                    "min": "1024"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 49,
                    "startLine": 46
                }
            },
            {
                "Type": "run_as_user",
                "Labels": [],
                "Attributes": {
                    "rule": "MustRunAs"
                },
                "Blocks": [
                    {
                        "Type": "range",
                        "Labels": [],
                        "Attributes": {
                            "max": "100",
                            "min": "1"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 59,
                            "startLine": 56
                        }
                    },
                    {
                        "Type": "range",
                        "Labels": [],
                        "Attributes": {
                            "max": "1024",
                            "min": "2"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 63,
                            "startLine": 60
                        }
                    }
                ],
                "line_range": {
                    "endLine": 64,
                    "startLine": 54
                }
            },
            {
                "Type": "run_as_group",
                "Labels": [],
                "Attributes": {
                    "rule": "MustRunAs"
                },
                "Blocks": [
                    {
                        "Type": "range",
                        "Labels": [],
                        "Attributes": {
                            "max": "100",
                            "min": "1"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 70,
                            "startLine": 67
                        }
                    },
                    {
                        "Type": "range",
                        "Labels": [],
                        "Attributes": {
                            "max": "1024",
                            "min": "2"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 74,
                            "startLine": 71
                        }
                    }
                ],
                "line_range": {
                    "endLine": 75,
                    "startLine": 65
                }
            },
            {
                "Type": "runtime_class",
                "Labels": [],
                "Attributes": {
                    "allowed_runtime_class_names": [
                        "something"
                    ],
                    "default_runtime_class_name": "something"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 79,
                    "startLine": 76
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
                    "endLine": 82,
                    "startLine": 80
                }
            },
            {
                "Type": "supplemental_group",
                "Labels": [],
                "Attributes": {
                    "rule": "RunAsAny"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 85,
                    "startLine": 83
                }
            }
        ],
        "line_range": {
            "endLine": 87,
            "startLine": 2
        }
    }]
    count(result) == 1
}