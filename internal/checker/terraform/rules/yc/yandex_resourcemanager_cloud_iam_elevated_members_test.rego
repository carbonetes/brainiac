package lib.terraform.CB_TFYC_013

test_yandex_resourcemanager_cloud_iam_elevated_members_passed {
	result := passed with input as [
    {
        "Type": "data",
        "Labels": [
            "yandex_resourcemanager_cloud",
            "project1"
        ],
        "Attributes": {
            "name": "Project 1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_resourcemanager_cloud_iam_binding",
            "admin"
        ],
        "Attributes": {
            "cloud_id": "data.yandex_resourcemanager_cloud.project1.id",
            "members": [
                "userAccount:some_user_id"
            ],
            "role": "member"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_yandex_resourcemanager_cloud_iam_elevated_members_failed {
	result := failed with input as [{
        "Type": "data",
        "Labels": [
            "yandex_resourcemanager_cloud",
            "project1"
        ],
        "Attributes": {
            "name": "Project 1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_resourcemanager_cloud_iam_binding",
            "admin"
        ],
        "Attributes": {
            "cloud_id": "data.yandex_resourcemanager_cloud.project1.id",
            "members": [
                "userAccount:some_user_id"
            ],
            "role": "editor"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 5
        }
    }]
	count(result) == 1
}