package lib.terraform.CB_TFYC_023

test_yandex_resourcemanager_folder_iam_restricted_roles_passed { 
    result := passed with input as [{
        "Type": "data",
        "Labels": [
            "yandex_resourcemanager_folder",
            "project1"
        ],
        "Attributes": {
            "folder_id": "some_folder_id"
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
            "yandex_resourcemanager_folder_iam_binding",
            "private"
        ],
        "Attributes": {
            "folder_id": "data.yandex_resourcemanager_folder.project1.id",
            "members": [
                "userAccount:some_user_id"
            ],
            "role": "private"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_yandex_resourcemanager_folder_iam_restricted_roles_failed { 
    result := failed with input as [{
        "Type": "data",
        "Labels": [
            "yandex_resourcemanager_folder",
            "project1"
        ],
        "Attributes": {
            "folder_id": "some_folder_id"
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
            "yandex_resourcemanager_folder_iam_binding",
            "admin"
        ],
        "Attributes": {
            "folder_id": "data.yandex_resourcemanager_folder.project1.id",
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