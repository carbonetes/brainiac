package lib.terraform.CB_TFRAN_110

test_rancher2_node_pool_configuration_with_node_taints_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_pool",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "rancher2_cluster.foo-custom.id",
            "control_plane": true,
            "etcd": true,
            "hostname_prefix": "foo-cluster-0",
            "name": "foo",
            "node_template_id": "rancher2_node_template.foo.id",
            "quantity": "1",
            "worker": true
        },
        "Blocks": [
            {
                "Type": "node_taints",
                "Labels": [],
                "Attributes": {
                    "effect": "NoExecute",
                    "key": "key1",
                    "value": "value1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 15,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 16,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_node_pool_configuration_with_node_taints_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_pool",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "rancher2_cluster.foo-custom.id",
            "control_plane": true,
            "etcd": true,
            "hostname_prefix": "foo-cluster-0",
            "name": "foo",
            "node_template_id": "rancher2_node_template.foo.id",
            "quantity": "1",
            "worker": true
        },
        "Blocks": [
            {
                "Type": "node_taints",
                "Labels": [],
                "Attributes": {
                    "effect": "NoExecute",
                    "key": "key1",
                    "value": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 15,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 16,
            "startLine": 2
        }
    }]
    count(result) == 1
}