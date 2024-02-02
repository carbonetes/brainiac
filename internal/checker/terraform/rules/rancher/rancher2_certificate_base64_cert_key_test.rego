package lib.terraform.CB_TFRAN_046

# https://play.openpolicyagent.org/p/bEGXlhfGVv - Base64 Rego Usage
# cert: base64.decode("<CERT>")
# key:  base64.decode("<PRIVATE_KEY>")
test_rancher2_certificate_base64_cert_key_passed {
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

test_rancher2_certificate_base64_cert_key_failed {
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