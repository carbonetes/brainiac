package lib.terraform.CB_TFRAN_100

test_rancher2_secret_v2_configuration_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_secret_v2",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "<CLUSTER_ID>",
            "data": {
                "mydata1": "<data1>",
                "mydata2": "<data2>",
                "mydata3": "<data3>"
            },
            "name": "foo"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_secret_v2_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_secret_v2",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "",
            "data": {},
            "name": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 2
        }
    }]
    count(result) == 1
}