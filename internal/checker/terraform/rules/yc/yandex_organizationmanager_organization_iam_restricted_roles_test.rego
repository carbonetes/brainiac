package lib.terraform.CB_TFYC_021

test_yandex_organizationmanager_organization_iam_restricted_roles_passed { 
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_organizationmanager_organization_iam_binding",
            "editor"
        ],
        "Attributes": {
            "members": [
                "userAccount:some_user_id"
            ],
            "organization_id": "some_organization_id",
            "role": "private"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_yandex_organizationmanager_organization_iam_restricted_roles_failed { 
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_organizationmanager_organization_iam_binding",
            "editor"
        ],
        "Attributes": {
            "members": [
                "userAccount:some_user_id"
            ],
            "organization_id": "some_organization_id",
            "role": "editor"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
	count(result) == 1
}