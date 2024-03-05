package lib.terraform.CB_TFRAN_101

test_rancher2_setting_configuration_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_setting",
            "foo"
        ],
        "Attributes": {
            "name": "foo",
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

test_rancher2_setting_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_setting",
            "foo"
        ],
        "Attributes": {
            "name": "",
            "value": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 2
        }
    }]
    count(result) == 1
}