package lib.terraform.CB_TFK8S_018

test_kubernetes_pod_development_security_context_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "kubernetes"
        ],
        "Attributes": {
            "config_path": "~/.kube/config"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
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
                    "annotations": {
                        "seccomp.security.alpha.kubernetes.io/defaultProfileName": "docker/default"
                    },
                    "name": "example-psp"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 12,
                    "startLine": 6
                }
            },
            {
                "Type": "spec",
                "Labels": [],
                "Attributes": {
                    "privileged": false
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 14
                }
            }
        ],
        "line_range": {
            "endLine": 18,
            "startLine": 5
        }
    }]
}

test_kubernetes_pod_development_security_context_failed {
	result := failed with input as [{
        "Type": "provider",
        "Labels": [
            "kubernetes"
        ],
        "Attributes": {
            "config_path": "~/.kube/config"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
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
                    "annotations": {
                        "seccomp.security.alpha.kubernetes.io/defaultProfileName": "docker/notdefault"
                    },
                    "name": "example-psp"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 12,
                    "startLine": 6
                }
            },
            {
                "Type": "spec",
                "Labels": [],
                "Attributes": {
                    "privileged": false
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 14
                }
            }
        ],
        "line_range": {
            "endLine": 18,
            "startLine": 5
        }
    }]
}