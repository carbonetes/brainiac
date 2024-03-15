package lib.terraform.CB_TFRAN_071

test_rancher2_cluster_alert_rule_configuration_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_alert_rule",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "rancher2_cluster_alert_group.foo.cluster_id",
            "group_id": "rancher2_cluster_alert_group.foo.id",
            "group_interval_seconds": "600",
            "name": "foo",
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

test_rancher2_cluster_alert_rule_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_alert_rule",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "",
            "group_id": "",
            "group_interval_seconds": "600",
            "name": "foo",
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