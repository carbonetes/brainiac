package lib.terraform.CB_TFIBM_051

import rego.v1

test_firewall_policy_protocol_is_secured_pass if {
	result := passed with input as [{
       "Type": "resource",
        "Labels": [
            "ibm_firewall_policy",
            "rules"
        ],
        "Attributes": {
            "firewall_id": "ibm_firewall.demofw.id"
        },
        "Blocks": [
            {
                "Type": "rules",
                "Labels": [],
                "Attributes": {
                    "action": "permit",
                    "dst_ip_address": "any",
                    "protocol": "udp",
                    "src_ip_cidr": "24"
                }
            }
        ]
    }]
	count(result) == 1
}

test_firewall_policy_protocol_is_secured_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_firewall_policy",
            "rules"
        ],
        "Attributes": {
            "firewall_id": "ibm_firewall.demofw.id"
        },
        "Blocks": [
            {
                "Type": "rules",
                "Labels": [],
                "Attributes": {
                    "action": "deny",
                    "dst_ip_address": "any",
                    "protocol": "udp",
                    "src_ip_cidr": "24"
                }
            }
        ]
    }]
	count(result) == 1
}
