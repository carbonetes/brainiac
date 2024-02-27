package lib.terraform.CB_TFRAN_125

test_rancher2_global_dns_multi_cluster_app_id_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_global_dns",
            "foo"
        ],
        "Attributes": {
            "fqdn": "foo.example.com",
            "multi_cluster_app_id": "<MCA_ID>",
            "name": "foo",
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

test_rancher2_global_dns_multi_cluster_app_id_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_global_dns",
            "foo"
        ],
        "Attributes": {
            "fqdn": "foo.example.com",
            "multi_cluster_app_id": "",
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