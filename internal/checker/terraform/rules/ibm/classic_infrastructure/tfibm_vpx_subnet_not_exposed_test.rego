package lib.terraform.CB_TFIBM_061

import rego.v1

test_vpx_subnets_not_exposed_pass if {
	result := passed with input as [{
         "Type": "resource",
        "Labels": [
            "ibm_lb_vpx",
            "test_vpx"
        ],
        "Attributes": {
            "datacenter": "dal06",
            "ip_count": "2",
            "management_ip_address": "",
            "name": "",
            "plan": "Standard",
            "private_subnet": "10.107.180.0/26",
            "private_vlan_id": "1.540786e+06",
            "public_subnet": "23.246.226.248/29",
            "public_vlan_id": "1.251234e+06",
            "speed": "10",
            "version": "10.1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_vpx_subnets_not_exposed_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_lb_vpx",
            "test_vpx"
        ],
        "Attributes": {
            "datacenter": "dal06",
            "ip_count": "2",
            "management_ip_address": "",
            "name": "",
            "plan": "Standard",
            "private_subnet": "0.0.0.0/26",
            "private_vlan_id": "1.540786e+06",
            "public_subnet": "0.0.0.0/29",
            "public_vlan_id": "0.251234e+06",
            "speed": "10",
            "version": "10.1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 1
        }
    }]
	count(result) == 1
}
