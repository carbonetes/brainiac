package lib.terraform.CB_TFIBM_095

import rego.v1

test_firewall_vlan_id_is_specified_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_firewall",
            "testfw"
        ],
        "Attributes": {
            "firewall_type": "HARDWARE_FIREWALL_DEDICATED",
            "ha_enabled": false,
            "public_vlan_id": "3124214",
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

test_firewall_vlan_id_is_specified_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_firewall",
            "testfw"
        ],
        "Attributes": {
            "firewall_type": "HARDWARE_FIREWALL_DEDICATED",
            "ha_enabled": false,
            "public_vlan_id": "",
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
