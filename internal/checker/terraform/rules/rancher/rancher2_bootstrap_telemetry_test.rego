package lib.terraform.CB_TFRAN_035

test_rancher2_bootstrap_telemetry_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "rancher2"
        ],
        "Attributes": {
            "api_url": "https://rancher.my-domain.com",
            "bootstrap": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 2
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "rancher2_bootstrap",
            "admin"
        ],
        "Attributes": {
            "password": "blahblah",
            "telemetry": false,
            "token_ttl": "<TOKEN_TTL>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 8
        }
    }]
    count(result) == 1
}

test_rancher2_bootstrap_telemetry_failed {
	result := failed with input as [{
        "Type": "provider",
        "Labels": [
            "rancher2"
        ],
        "Attributes": {
            "api_url": "https://rancher.my-domain.com",
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 2
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "rancher2_bootstrap",
            "admin"
        ],
        "Attributes": {
            "password": "blahblah"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 8
        }
    }]
    count(result) == 1
}