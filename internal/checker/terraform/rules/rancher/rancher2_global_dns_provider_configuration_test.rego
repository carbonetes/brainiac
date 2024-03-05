package lib.terraform.CB_TFRAN_082

test_rancher2_global_dns_provider_configuration_passed {
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
                "Type": "alidns_config",
                "Labels": [],
                "Attributes": {
                    "access_key": "YYYYYYYYYYYYYYYYYYYY",
                    "secret_key": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 8,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 9,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_global_dns_provider_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_global_dns_provider",
            "foo"
        ],
        "Attributes": {
            "name": "foo",
            "root_domain": ""
        },
        "Blocks": [
            {
                "Type": "alidns_config",
                "Labels": [],
                "Attributes": {
                    "access_key": "YYYYYYYYYYYYYYYYYYYY",
                    "secret_key": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 8,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 9,
            "startLine": 2
        }
    }]
    count(result) == 1
}