package lib.terraform.CB_TFRAN_057

test_rancher2_cloud_credential_vmwarevsphere_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "example"
        ],
        "Attributes": {
            "description": "Example VMWarevSphere Credential Configuration",
            "name": "example-credential"
        },
        "Blocks": [
            {
                "Type": "vsphere_credential_config",
                "Labels": [],
                "Attributes": {
                    "password": "<VSphere_Password>",
                    "username": "<VSphere_Username>",
                    "vcenter": "<VSphere_IP_or_Hostname>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 10,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 11,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_cloud_credential_vmwarevsphere_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "example"
        ],
        "Attributes": {
            "description": "Example VMWarevSphere Credential Configuration",
            "name": "example-credential"
        },
        "Blocks": [
            {
                "Type": "vsphere_credential_config",
                "Labels": [],
                "Attributes": {
                    "password": "",
                    "username": "",
                    "vcenter": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 10,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 11,
            "startLine": 1
        }
    }]
    count(result) == 1
}