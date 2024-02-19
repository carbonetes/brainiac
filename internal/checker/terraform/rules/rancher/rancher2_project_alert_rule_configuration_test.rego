package lib.terraform.CB_TFRAN_095

test_rancher2_project_alert_rule_configuration_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_project_alert_rule",
            "foo"
        ],
        "Attributes": {
            "group_id": "rancher2_project_alert_group.foo.id",
            "group_interval_seconds": "600",
            "name": "foo",
            "project_id": "rancher2_project_alert_group.foo.project_id",
            "repeat_interval_seconds": "6000"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_project_alert_rule_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_project_alert_rule",
            "foo"
        ],
        "Attributes": {
            "group_id": "",
            "group_interval_seconds": "600",
            "name": "",
            "project_id": "",
            "repeat_interval_seconds": "6000"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 2
        }
    }]
    count(result) == 1
}