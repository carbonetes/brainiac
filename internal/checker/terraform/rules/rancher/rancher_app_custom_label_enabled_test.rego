package lib.terraform.CB_TFRAN_005

test_rancher_app_custom_label_enabled_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "rancher2"
        ],
        "Attributes": {
            "token": "your-rancher-api-token",
            "url": "https://rancher.yourcompany.com"
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
            "rancher2_app",
            "example_app"
        ],
        "Attributes": {
            "catalog_name": "your-catalog-name",
            "description": "Example Rancher2 App with custom label",
            "labels": {
                "custom_label": "true"
            },
            "name": "my-app-with-custom-label",
            "project_id": "your-project-id",
            "target_namespace": "default",
            "template_name": "your-template-name",
            "template_version": "your-template-version"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 18,
            "startLine": 6
        }
    }]
    count(result) == 1
}

test_rancher_app_custom_label_enabled_failed {
	result := failed with input as [{
        "Type": "provider",
        "Labels": [
            "rancher2"
        ],
        "Attributes": {
            "token": "your-rancher-api-token",
            "url": "https://rancher.yourcompany.com"
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
            "rancher2_app",
            "example_app"
        ],
        "Attributes": {
            "catalog_name": "your-catalog-name",
            "description": "Example Rancher2 App with custom label",
            "name": "my-app-with-custom-label",
            "project_id": "your-project-id",
            "target_namespace": "default",
            "template_name": "your-template-name",
            "template_version": "your-template-version"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 18,
            "startLine": 6
        }
    }]
    count(result) == 1
}

test_rancher_app_v2_custom_label_enabled_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "rancher2"
        ],
        "Attributes": {
            "token": "your-rancher-api-token",
            "url": "https://rancher.yourcompany.com"
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
            "rancher2_app_v2",
            "example_app"
        ],
        "Attributes": {
            "labels": {
                "custom_label": "true"
            },
            "name": "my-app-with-custom-label",
            "namespace": "default",
            "project_id": "your-project-id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 15,
            "startLine": 6
        }
    }]
    count(result) == 1
}


test_rancher_app_v2_custom_label_enabled_failed {
	result := failed with input as [{
        "Type": "provider",
        "Labels": [
            "rancher2"
        ],
        "Attributes": {
            "token": "your-rancher-api-token",
            "url": "https://rancher.yourcompany.com"
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
            "rancher2_app_v2",
            "example_app"
        ],
        "Attributes": {
            "name": "my-app-with-custom-label",
            "namespace": "default",
            "project_id": "your-project-id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 15,
            "startLine": 6
        }
    }]
    count(result) == 1
}