package lib.terraform.CB_TFRAN_145

test_rancher2_node_pool_quantity_passed {
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
            "quantity": 1,
            "worker": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_node_pool_quantity_failed {
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
            "quantity": -1,
            "worker": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 2
        }
    }]
    count(result) == 1
}