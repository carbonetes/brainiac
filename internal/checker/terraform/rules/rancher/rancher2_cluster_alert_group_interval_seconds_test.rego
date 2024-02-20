package lib.terraform.CB_TFRAN_070

test_rancher2_cluster_alert_group_interval_seconds_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_alert_group",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "<cluster_id>",
            "description": "Terraform cluster alert group",
            "group_interval_seconds": 300,
            "group_wait_seconds": 1,
            "name": "foo",
            "repeat_interval_seconds": 3600
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_alert_group_interval_seconds_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_alert_group",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "",
            "description": "Terraform cluster alert group",
            "group_interval_seconds": -3,
            "name": "foo",
            "repeat_interval_seconds": "not a number"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 2
        }
    }]
    count(result) == 1
}