package lib.terraform.CB_TFRAN_047

test_rancher2_certificate_naming_convention_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_certificate",
            "foo"
        ],
        "Attributes": {
            "certs": "PENFUlQ+",
            "description": "Terraform certificate foo",
            "key": "PFBSSVZBVEVfS0VZPg==",
            "name": "cert-foo",
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

test_rancher2_certificate_naming_convention_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_certificate",
            "foo"
        ],
        "Attributes": {
            "certs": "<CERT>",
            "description": "Terraform certificate foo",
            "key": "<PRIVATE_KEY>",
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