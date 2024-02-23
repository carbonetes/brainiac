package lib.terraform.CB_TFRAN_102

test_rancher2_storage_class_v2_configuration_passed {
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
            "reclaim_policy": "Delete"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_storage_class_v2_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_storage_class_v2",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "",
            "k8s_provisioner": "",
            "name": "",
            "parameters": {
                "gidAllocate": "true",
                "gidMax": "50000",
                "gidMin": "40000"
            },
            "reclaim_policy": "Delete"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 2
        }
    }]
    count(result) == 1
}