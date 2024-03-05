package lib.terraform.CB_TFRAN_045

test_rancher2_certificate_namespace_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_certificate",
            "foo"
        ],
        "Attributes": {
            "certs": "base64encode(<PUBLIC_CERTS>)",
            "description": "Terraform certificate foo",
            "key": "base64encode(<PRIVATE_KEY>)",
            "name": "foo",
            "project_id": "<project_id>",
            "namespace_id": "<namespace>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_certificate_namespace_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_certificate",
            "foo"
        ],
        "Attributes": {
            "certs": "base64encode(<PUBLIC_CERTS>)",
            "description": "Terraform certificate foo",
            "key": "base64encode(<PRIVATE_KEY>)",
            "name": "foo",
            "namespace_id": "<namespace>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 2
        }
    }]
    count(result) == 1
}