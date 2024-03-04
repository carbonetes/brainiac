package lib.terraform.CB_TFRAN_191

test_rancher2_cluster_v2_pod_security_policy_template_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_v2",
            "foo"
        ],
        "Attributes": {
            "default_pod_security_admission_configuration_template_name": "rancher-restricted",
            "default_pod_security_policy_template_name": "restricted-noroot",
            "enable_network_policy": false,
            "kubernetes_version": "rke2/k3s-version",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "rke_config",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "machine_pools",
                        "Labels": [],
                        "Attributes": {},
                        "Blocks": [],
                        "line_range": {
                            "endLine": 18,
                            "startLine": 16
                        }
                    }
                ],
                "line_range": {
                    "endLine": 19,
                    "startLine": 8
                }
            }
        ],
        "line_range": {
            "endLine": 20,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_v2_pod_security_policy_template_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_v2",
            "foo"
        ],
        "Attributes": {
            "default_pod_security_admission_configuration_template_name": "rancher-restricted",
            "default_pod_security_policy_template_name": "not_a_policy",
            "enable_network_policy": false,
            "kubernetes_version": "rke2/k3s-version",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "rke_config",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "machine_pools",
                        "Labels": [],
                        "Attributes": {},
                        "Blocks": [],
                        "line_range": {
                            "endLine": 18,
                            "startLine": 16
                        }
                    }
                ],
                "line_range": {
                    "endLine": 19,
                    "startLine": 8
                }
            }
        ],
        "line_range": {
            "endLine": 20,
            "startLine": 1
        }
    }]
    count(result) == 1
}