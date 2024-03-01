package lib.terraform.CB_TFRAN_186

test_rancher2_token_renew_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_token",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "<cluster-id>",
            "description": "foo token",
            "renew": true,
            "ttl": "1200"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_token_renew_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_token",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "<cluster-id>",
            "description": "foo token",
            "renew": false,
            "ttl": "1200"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 2
        }
    }]
    count(result) == 1
}