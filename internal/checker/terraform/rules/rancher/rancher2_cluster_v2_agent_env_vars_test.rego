package lib.terraform.CB_TFRAN_188

test_rancher2_cluster_v2_agent_env_vars_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_v2",
            "foo"
        ],
        "Attributes": {
            "kubernetes_version": "rke2/k3s-version",
            "name": "cluster-with-agent-env-vars"
        },
        "Blocks": [
            {
                "Type": "agent_env_vars",
                "Labels": [],
                "Attributes": {
                    "name": "foo1",
                    "value": "boo1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 4
                }
            },
            {
                "Type": "agent_env_vars",
                "Labels": [],
                "Attributes": {
                    "name": "foo2",
                    "value": "boo2"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 12,
                    "startLine": 9
                }
            },
            {
                "Type": "rke_config",
                "Labels": [],
                "Attributes": {},
                "Blocks": [],
                "line_range": {
                    "endLine": 15,
                    "startLine": 13
                }
            }
        ],
        "line_range": {
            "endLine": 16,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_v2_agent_env_vars_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_v2",
            "foo"
        ],
        "Attributes": {
            "kubernetes_version": "rke2/k3s-version",
            "name": "cluster-with-agent-env-vars"
        },
        "Blocks": [
            {
                "Type": "agent_env_vars",
                "Labels": [],
                "Attributes": {
                    "name": "",
                    "value": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 4
                }
            },
            {
                "Type": "agent_env_vars",
                "Labels": [],
                "Attributes": {
                    "name": "",
                    "value": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 12,
                    "startLine": 9
                }
            },
            {
                "Type": "rke_config",
                "Labels": [],
                "Attributes": {},
                "Blocks": [],
                "line_range": {
                    "endLine": 15,
                    "startLine": 13
                }
            }
        ],
        "line_range": {
            "endLine": 16,
            "startLine": 1
        }
    }]
    count(result) == 1
}