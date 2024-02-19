package lib.terraform.CB_TFRAN_111

test_rancher2_project_alert_group_interval_seconds_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_project_alert_group",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform project alert group",
            "group_interval_seconds": 300,
            "group_wait_seconds": 1,
            "name": "foo",
            "project_id": "<project_id>",
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

test_rancher2_project_alert_group_interval_seconds_failed {
    result := failed with input as[{
        "Type": "resource",
        "Labels": [
            "rancher2_project_alert_group",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform project alert group",
            "group_interval_seconds": -5,
            "name": "foo",
            "project_id": "<project_id>",
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