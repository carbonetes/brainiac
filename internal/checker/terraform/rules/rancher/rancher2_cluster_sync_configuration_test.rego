package lib.terraform.CB_TFRAN_074

test_rancher2_cluster_sync_configuration_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_sync",
            "foo-custom"
        ],
        "Attributes": {
            "cluster_id": "rancher2_cluster.foo-custom.id",
            "node_pool_ids": "rancher2_node_pool.foo.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_sync_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_sync",
            "foo-custom"
        ],
        "Attributes": {
            "cluster_id": "",
            "node_pool_ids": "rancher2_node_pool.foo.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 2
        }
    }]
    count(result) == 1
}