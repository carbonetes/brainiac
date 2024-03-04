package lib.terraform.CB_TFRAN_189

test_rancher2_feature_value_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_feature",
            "fleet"
        ],
        "Attributes": {
            "name": "fleet",
            "value": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_feature_value_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_feature",
            "fleet"
        ],
        "Attributes": {
            "name": "fleet",
            "value": "not boolean"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 2
        }
    }]
    count(result) == 1
}