package lib.terraform.CB_TFRAN_185

test_rancher2_storage_class_v2_volume_binding_mode_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_storage_class_v2",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "<CLUSTER_ID>",
            "k8s_provisioner": "example.com/aws-efs",
            "name": "foo",
            "parameters": {
                "gidAllocate": "true",
                "gidMax": "50000",
                "gidMin": "40000"
            },
            "reclaim_policy": "Delete",
            "volume_binding_mode": "Immediate"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_storage_class_v2_volume_binding_mode_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_storage_class_v2",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "<CLUSTER_ID>",
            "k8s_provisioner": "example.com/aws-efs",
            "name": "foo",
            "parameters": {
                "gidAllocate": "true",
                "gidMax": "50000",
                "gidMin": "40000"
            },
            "reclaim_policy": "Delete",
            "volume_binding_mode": "not_a_mode"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 2
        }
    }]
    count(result) == 1
}