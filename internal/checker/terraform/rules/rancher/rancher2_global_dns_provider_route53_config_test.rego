package lib.terraform.CB_TFRAN_129

test_rancher2_global_dns_provider_route53_config_passed {
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
                "Type": "route53_config",
                "Labels": [],
                "Attributes": {
                    "access_key": "YYYYYYYYYYYYYYYYYYYY",
                    "region": "us-east-1",
                    "secret_key": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
                    "zone_type": "private"
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
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_global_dns_provider_route53_config_failed {
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
                "Type": "route53_config",
                "Labels": [],
                "Attributes": {
                    "access_key": "",
                    "region": "us-east-1",
                    "secret_key": "",
                    "zone_type": "private"
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
            "startLine": 2
        }
    }]
    count(result) == 1
}