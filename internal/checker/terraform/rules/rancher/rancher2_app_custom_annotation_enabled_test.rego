package lib.terraform.CB_TFRAN_004

test_rancher2_app_custom_annotation_enabled_passed {
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
            "annotations": {
                "custom_annotation": true
            },
            "catalog_name": "community",
            "name": "my-app-with-annotation",
            "project_id": "your-project-id",
            "target_namespace": "default",
            "template_name": "nginx",
            "template_version": "v1.21.1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 6
        }
    }]
    count(result) == 1
}

test_rancher2_app_custom_annotation_enabled_failed {
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
            "name": "my-app-with-annotation",
            "project_id": "your-project-id",
            "target_namespace": "default",
            "template_name": "nginx",
            "template_version": "v1.21.1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 17,
            "startLine": 6
        }
    }]
    count(result) == 1
}

test_rancher2_app_v2_custom_annotation_enabled_passed {
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
            "annotations": {
                "custom_annotation": "true"
            },
            "name": "my-app-with-annotation",
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


test_rancher2_app_v2_custom_annotation_enabled_failed {
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
            "name": "my-app-with-annotation",
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