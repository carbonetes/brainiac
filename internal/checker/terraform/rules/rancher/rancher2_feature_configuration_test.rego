package lib.terraform.CB_TFRAN_080

test_rancher2_feature_configuration_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_feature",
            "fleet"
        ],
        "Attributes": {
            "name": "fleet",
            "value": "<VALUE>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_feature_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_feature",
            "fleet"
        ],
        "Attributes": {
            "name": "",
            "value": "<VALUE>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 2
        }
    }]
    count(result) == 1
}