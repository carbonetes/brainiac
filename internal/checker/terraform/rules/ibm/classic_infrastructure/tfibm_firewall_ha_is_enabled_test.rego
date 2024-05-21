package lib.terraform.CB_TFIBM_089

import rego.v1

test_firewall_ha_is_enabled_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_firewall",
            "testfw"
        ],
        "Attributes": {
            "firewall_type": "HARDWARE_FIREWALL_DEDICATED",
            "ha_enabled": true,
            "public_vlan_id": "1.2345678e+07",
            "tags": [
                "collectd",
                "mesos-master"
            ]
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_firewall_ha_is_enabled_fail if {
	result := failed with input as [{
         "Type": "resource",
        "Labels": [
            "ibm_firewall",
            "testfw"
        ],
        "Attributes": {
            "firewall_type": "HARDWARE_FIREWALL_DEDICATED",
            "ha_enabled": false,
            "public_vlan_id": "1.2345678e+07",
            "tags": [
                "collectd",
                "mesos-master"
            ]
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
	count(result) == 1
}
