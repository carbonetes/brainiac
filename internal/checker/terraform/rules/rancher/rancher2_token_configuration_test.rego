package lib.terraform.CB_TFRAN_103

test_rancher2_token_configuration_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_token",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "<cluster-id>",
            "description": "foo token",
            "ttl": "1200"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_token_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_token",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "",
            "description": "",
            "ttl": "1200"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 2
        }
    }]
    count(result) == 1
}