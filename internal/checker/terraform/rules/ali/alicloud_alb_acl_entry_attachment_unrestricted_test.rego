package lib.terraform.CB_TFALI_020

test_alicloud_alb_acl_entry_attachment_unrestricted_passed {
	result := passed with input as [{
        "Type": "variable",
        "Labels": [
            "name"
        ],
        "Attributes": {
            "default": "tf_example"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_resource_manager_resource_groups",
            "default"
        ],
        "Attributes": {},
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 4
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_alb_acl",
            "default"
        ],
        "Attributes": {
            "acl_name": "var.name",
            "resource_group_id": "data.alicloud_resource_manager_resource_groups.default.groups..id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 6
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_alb_acl_entry_attachment",
            "default"
        ],
        "Attributes": {
            "acl_id": "alicloud_alb_acl.default.id",
            "description": "var.name",
            "entry": "168.10.10.0/24"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 15,
            "startLine": 11
        }
    }]
	count(result) == 1
}

test_alicloud_alb_acl_entry_attachment_unrestricted_failed {
	result := failed with input as [{
        "Type": "variable",
        "Labels": [
            "name"
        ],
        "Attributes": {
            "default": "tf_example"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "data",
        "Labels": [
            "alicloud_resource_manager_resource_groups",
            "default"
        ],
        "Attributes": {},
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 4
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_alb_acl",
            "default"
        ],
        "Attributes": {
            "acl_name": "var.name",
            "resource_group_id": "data.alicloud_resource_manager_resource_groups.default.groups..id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 6
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "alicloud_alb_acl_entry_attachment",
            "default"
        ],
        "Attributes": {
            "acl_id": "alicloud_alb_acl.default.id",
            "description": "var.name",
            "entry": "0.0.0.0/0"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 15,
            "startLine": 11
        }
    }]
	count(result) == 1
}