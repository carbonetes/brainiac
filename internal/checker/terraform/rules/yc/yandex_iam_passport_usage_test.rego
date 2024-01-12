package lib.terraform.CB_TFYC_024

test_yandex_resourcemanager_folder_iam_binding_passport_usage_passed { 
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
            "admin"
        ],
        "Attributes": {
            "folder_id": "data.yandex_resourcemanager_folder.project1.id",
            "members": [
                "serviceAccount:some_user_id"
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

test_yandex_resourcemanager_folder_iam_binding_passport_usage_failed { 
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

test_yandex_resourcemanager_folder_iam_member_passport_usage_passed { 
    result := passed with input as [{
        "Type": "data",
        "Labels": [
            "yandex_resourcemanager_folder",
            "department1"
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
            "yandex_resourcemanager_folder_iam_member",
            "admin"
        ],
        "Attributes": {
            "folder_id": "data.yandex_resourcemanager.department1.name",
            "member": "serviceAccount:user_id",
            "role": "editor"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_yandex_resourcemanager_folder_iam_member_passport_usage_failed { 
    result := failed with input as [{
        "Type": "data",
        "Labels": [
            "yandex_resourcemanager_folder",
            "department1"
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
            "yandex_resourcemanager_folder_iam_member",
            "admin"
        ],
        "Attributes": {
            "folder_id": "data.yandex_resourcemanager.department1.name",
            "member": "userAccount:user_id",
            "role": "editor"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_yandex_resourcemanager_cloud_iam_binding_passport_usage_passed { 
    result := passed with input as [{
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
                "serviceAccount:some_user_id"
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

test_yandex_resourcemanager_cloud_iam_binding_passport_usage_failed { 
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

test_yandex_resourcemanager_cloud_iam_member_passport_usage_passed { 
    result := passed with input as [{
        "Type": "data",
        "Labels": [
            "yandex_resourcemanager_cloud",
            "department1"
        ],
        "Attributes": {
            "name": "Department 1"
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
            "yandex_resourcemanager_cloud_iam_member",
            "admin"
        ],
        "Attributes": {
            "cloud_id": "data.yandex_resourcemanager_cloud.department1.id",
            "member": "serviceAccount:user_id",
            "role": "editor"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 5
        }
    }]
    count(result) == 1
}

test_yandex_resourcemanager_cloud_iam_member_passport_usage_failed { 
    result := failed with input as [{
        "Type": "data",
        "Labels": [
            "yandex_resourcemanager_cloud",
            "department1"
        ],
        "Attributes": {
            "name": "Department 1"
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
            "yandex_resourcemanager_cloud_iam_member",
            "admin"
        ],
        "Attributes": {
            "cloud_id": "data.yandex_resourcemanager_cloud.department1.id",
            "member": "userAccount:user_id",
            "role": "editor"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 5
        }
    }]
    count(result) == 1
}

test_yandex_organizationmanager_organization_iam_binding_passport_usage_passed { 
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_organizationmanager_organization_iam_binding",
            "editor"
        ],
        "Attributes": {
            "members": [
                "serviceAccount:some_user_id"
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

test_yandex_organizationmanager_organization_iam_binding_passport_usage_failed { 
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

test_yandex_organizationmanager_organization_iam_member_passport_usage_passed { 
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_organizationmanager_organization_iam_member",
            "editor"
        ],
        "Attributes": {
            "member": "serviceAccount:user_id",
            "organization_id": "some_organization_id",
            "role": "editor"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_yandex_organizationmanager_organization_iam_member_passport_usage_failed { 
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_organizationmanager_organization_iam_member",
            "editor"
        ],
        "Attributes": {
            "member": "userAccount:user_id",
            "organization_id": "some_organization_id",
            "role": "editor"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
    count(result) == 1
}


