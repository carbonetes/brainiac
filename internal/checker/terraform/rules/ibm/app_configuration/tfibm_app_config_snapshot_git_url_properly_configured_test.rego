package lib.terraform.CB_TFIBM_100

import rego.v1 

test_tfibm_app_config_snapshot_git_token_not_exposed_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_app_config_snapshot",
            "app_config_snapshot"
        ],
        "Attributes": {
            "collection_id": "collection_id",
            "environment_id": "environment_id",
            "git_branch": "git_branch",
            "git_config_id": "git_config_id",
            "git_config_name": "git_config_name",
            "git_file_path": "git_file_path",
            "git_token": "git_token",
            "git_url": "https://api.github.com/repos/owner/repo_name",
            "guid": "guid"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_tfibm_app_config_snapshot_git_token_not_exposed_failed if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_app_config_snapshot",
            "app_config_snapshot"
        ],
        "Attributes": {
            "collection_id": "collection_id",
            "environment_id": "environment_id",
            "git_branch": "git_branch",
            "git_config_id": "git_config_id",
            "git_config_name": "git_config_name",
            "git_file_path": "git_file_path",
            "git_token": "git_token",
            "git_url": "git_url",
            "guid": "guid"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 1
        }
    }
]
	count(result) == 1
}