package lib.terraform.CB_TFAZR_093

test_azurerm_data_factory_uses_git_repository_passed {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "example-resources"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 4,
                "startLine": 1
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_data_factory",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "github_configuration",
                    "Labels": [],
                    "Attributes": {
                        "account_name": "sample_account_name",
                        "git_url": "sample_url",
                        "repository_name": "sample_repo",
                        "root_folder": "/"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 16,
                        "startLine": 11
                    }
                },
                {
                    "Type": "vsts_configuration",
                    "Labels": [],
                    "Attributes": {
                        "account_name": "sample_account_name",
                        "git_url": "sample_url",
                        "repository_name": "sample_repo",
                        "root_folder": "/"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 16,
                        "startLine": 11
                    }
                }
            ],
            "line_range": {
                "endLine": 17,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}

test_azurerm_data_factory_uses_git_repository_failed {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "example-resources"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 4,
                "startLine": 1
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_data_factory",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "github_configuration",
                    "Labels": [],
                    "Attributes": {
                        "account_name": "sample_account_name",
                        "git_url": "sample_url",
                        "root_folder": "/"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 16,
                        "startLine": 11
                    }
                },
                {
                    "Type": "vsts_configuration",
                    "Labels": [],
                    "Attributes": {
                        "account_name": "sample_account_name",
                        "git_url": "sample_url",
                        "root_folder": "/"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 16,
                        "startLine": 11
                    }
                }
            ],
            "line_range": {
                "endLine": 17,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}