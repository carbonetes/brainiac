package lib.terraform.CB_TFRAN_081

test_rancher2_global_dns_configuration_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_global_dns",
            "foo"
        ],
        "Attributes": {
            "fqdn": "foo.example.com",
            "name": "foo",
            "project_ids": [
                "project1",
                "project2"
            ],
            "provider_id": "rancher2_global_dns_provider.foo.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_global_dns_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_global_dns",
            "foo"
        ],
        "Attributes": {
            "fqdn": "foo.example.com",
            "name": "foo",
            "project_ids": [
                "project1",
                "project2"
            ],
            "provider_id": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 2
        }
    }]
    count(result) == 1
}