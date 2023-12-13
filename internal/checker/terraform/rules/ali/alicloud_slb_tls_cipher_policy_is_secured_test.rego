package lib.terraform.CB_TFALI_032

test_alicloud_slb_tls_cipher_policy_is_secured_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "alicloud_slb_tls_cipher_policy",
            "example"
        ],
        "Attributes": {
            "ciphers": [
                "AES256-SHA256",
                "AES128-GCM-SHA256"
            ],
            "tls_cipher_policy_name": "Test-example_value",
            "tls_versions": [
                "TLSv1.2"
            ]
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_alicloud_slb_tls_cipher_policy_is_secured_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "alicloud_slb_tls_cipher_policy",
            "example"
        ],
        "Attributes": {
            "ciphers": [
                "AES256-SHA256",
                "AES128-GCM-SHA256"
            ],
            "tls_cipher_policy_name": "Test-example_value",
            "tls_versions": [
                "TLSv1.1"
            ]
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}