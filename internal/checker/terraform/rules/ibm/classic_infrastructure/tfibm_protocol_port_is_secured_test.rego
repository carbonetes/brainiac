package lib.terraform.CB_TFIBM_039

import rego.v1

test_protocol_port_is_secured_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cdn",
            "test_cdn1"
        ],
        "Attributes": {
            "bucket_name": "example_bucket",
            "cache_key_query_rule": "include-all",
            "certificate_type": "SHARED_SAN_CERT",
            "cname": "cdn.example.com",
            "file_extension": ".html .css .js",
            "header": "X-Custom-Header",
            "host_name": "cdn.example.com",
            "http_port": 80,
            "https_port": 0,
            "protocol": "HTTPS"
        }
    }]
	count(result) == 1
}

test_protocol_port_is_secured_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cdn",
            "test_cdn1"
        ],
        "Attributes": {
            "bucket_name": "example_bucket",
            "cache_key_query_rule": "include-all",
            "certificate_type": "SHARED_SAN_CERT",
            "cname": "cdn.example.com",
            "file_extension": ".html .css .js",
            "header": "X-Custom-Header",
            "host_name": "cdn.example.com",
            "http_port": 70,
            "https_port": 0,
            "protocol": "TCP"
        }
    }]
	count(result) == 1
}
