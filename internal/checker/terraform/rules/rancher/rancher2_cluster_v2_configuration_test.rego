package lib.terraform.CB_TFRAN_076

test_rancher2_cluster_v2_configuration_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_v2",
            "foo"
        ],
        "Attributes": {
            "kubernetes_version": "rke2/k3s-version",
            "name": "foo"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_v2_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_v2",
            "foo"
        ],
        "Attributes": {
            "kubernetes_version": "not a version",
            "name": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 1
        }
    }]
    count(result) == 1
}