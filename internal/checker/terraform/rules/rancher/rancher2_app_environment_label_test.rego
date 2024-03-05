package lib.terraform.CB_TFRAN_003

test_rancher2_app_environment_label_passed {
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
            "catalog_name": "community",
            "labels": {
                "app_type": "web",
                "environment": "production"
            },
            "name": "my-production-app",
            "project_id": "1a5",
            "target_namespace": "production",
            "template_name": "nginx",
            "template_version": "v1.21.1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 19,
            "startLine": 6
        }
    }]
count(result) == 1
}

test_rancher2_app_environment_label_failed {
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
            "catalog_name": "community",
            "labels": {
                "app_type": "web"
            },
            "name": "my-production-app",
            "project_id": "1a5",
            "target_namespace": "production",
            "template_name": "nginx",
            "template_version": "v1.21.1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 19,
            "startLine": 6
        }
    }]
count(result) == 1
}

test_rancher_app_v2_environment_label_passed {
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
                "environment": "production"
            },
            "name": "my-app-with-environment-label",
            "namespace": "default",
            "project_id": "your-project-id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 6
        }
    }]
count(result) == 1
}

test_rancher_app_v2_environment_label_failed {
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
            "name": "my-app-with-environment-label",
            "namespace": "default",
            "project_id": "your-project-id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 6
        }
    }]
count(result) == 1
}