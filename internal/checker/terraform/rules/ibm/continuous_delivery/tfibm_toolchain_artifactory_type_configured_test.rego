package lib.terraform.CB_TFIBM_113

import rego.v1

test_toolchain_artifactory_type_configured_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cd_toolchain_tool_artifactory",
            "cd_toolchain_tool_artifactory_instance"
        ],
        "Attributes": {
            "toolchain_id": "ibm_cd_toolchain.cd_toolchain.id"
        },
        "Blocks": [
            {
                "Type": "parameters",
                "Labels": [],
                "Attributes": {
                    "dashboard_url": "https://mycompany.example.jfrog.io",
                    "mirror_url": "https://mirror.example.com",
                    "name": "artifactory-tool-01",
                    "release_url": "https://releases.example.com",
                    "repository_name": "default-docker-local",
                    "repository_url": "https://mycompany.example.jfrog.io/artifactory/default-docker-local",
                    "snapshot_url": "https://snapshots.example.com",
                    "token": "your_token_here",
                    "type": "docker",
                    "user_id": "your_user_id_here"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 13,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_toolchain_artifactory_type_configured_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cd_toolchain_tool_artifactory",
            "cd_toolchain_tool_artifactory_instance"
        ],
        "Attributes": {
            "toolchain_id": "ibm_cd_toolchain.cd_toolchain.id"
        },
        "Blocks": [
            {
                "Type": "parameters",
                "Labels": [],
                "Attributes": {
                    "dashboard_url": "http://mycompany.example.jfrog.io",
                    "mirror_url": "https://mirror.example.com",
                    "name": "artifactory-tool-01",
                    "release_url": "http://releases.example.com",
                    "repository_name": "default-docker-local",
                    "repository_url": "https://mycompany.example.jfrog.io/artifactory/default-docker-local",
                    "snapshot_url": "http://snapshots.example.com",
                    "token": "your_token_here",
                    "type": "...",
                    "user_id": "your_user_id_here"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 13,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 1
        }
    }]
	count(result) == 1
}
