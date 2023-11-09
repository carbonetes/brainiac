package lib.terraform.CB_TFGCP_030

test_google_project_default_network_disabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_project",
            "my_project-in-a-folder"
        ],
        "Attributes": {
            "auto_create_network": false,
            "folder_id": "google_folder.department1.name",
            "name": "My Project",
            "project_id": "your-project-id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_folder",
            "department1"
        ],
        "Attributes": {
            "display_name": "Department 1",
            "parent": "organizations/1234567"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 8
        }
    }]
	count(result) == 1
}

test_google_project_default_network_disabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_project",
            "my_project-in-a-folder"
        ],
        "Attributes": {
            "auto_create_network": true,
            "folder_id": "google_folder.department1.name",
            "name": "My Project",
            "project_id": "your-project-id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_folder",
            "department1"
        ],
        "Attributes": {
            "display_name": "Department 1",
            "parent": "organizations/1234567"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 8
        }
    }]
	count(result) == 1
}