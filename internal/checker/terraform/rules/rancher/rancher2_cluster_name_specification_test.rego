package lib.terraform.CB_TFRAN_058

test_rancher2_cluster_name_specification_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster",
            "foo-imported"
        ],
        "Attributes": {
            "description": "Foo rancher2 imported cluster",
            "name": "foo-imported"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_name_specification_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster",
            "foo-imported"
        ],
        "Attributes": {
            "description": "Foo rancher2 imported cluster",
            "name": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 2
        }
    }]
    count(result) == 1
}