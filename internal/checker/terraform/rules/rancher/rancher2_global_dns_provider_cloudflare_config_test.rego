package lib.terraform.CB_TFRAN_128

test_rancher2_global_dns_provider_cloudflare_config_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_global_dns_provider",
            "foo"
        ],
        "Attributes": {
            "name": "foo",
            "root_domain": "example.com"
        },
        "Blocks": [
            {
                "Type": "cloudflare_config",
                "Labels": [],
                "Attributes": {
                    "api_email": "test@test.local",
                    "api_key": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
                    "proxy_setting": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 10,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_global_dns_provider_cloudflare_config_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_global_dns_provider",
            "foo"
        ],
        "Attributes": {
            "name": "foo",
            "root_domain": "example.com"
        },
        "Blocks": [
            {
                "Type": "cloudflare_config",
                "Labels": [],
                "Attributes": {
                    "api_email": "",
                    "api_key": "",
                    "proxy_setting": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 10,
            "startLine": 2
        }
    }]
    count(result) == 1
}