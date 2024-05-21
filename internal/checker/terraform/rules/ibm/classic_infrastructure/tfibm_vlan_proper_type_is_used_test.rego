package lib.terraform.CB_TFIBM_084

import rego.v1

test_vlan_proper_type_is_used_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_network_vlan",
            "test_vlan"
        ],
        "Attributes": {
            "child_resource_count": "self.child_resource_count",
            "datacenter": "dal06",
            "id": "self.id",
            "name": "test_vlan",
            "router_hostname": "fcr01a.dal06",
            "softlayer_managed": "self.softlayer_managed",
            "tags": [
                "collectd",
                "mesos-master"
            ],
            "type": "PUBLIC"
        },
        "Blocks": [
            {
                "Type": "subnets",
                "Labels": [],
                "Attributes": {
                    "cidr": "1.3.4.5/24",
                    "gateway": "1.3.4.5/2",
                    "subnet": "1.3.4.5/2",
                    "subnet_size": "24",
                    "subnet_type": "PRIMARY",
                    "vlan_number": "123"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 19,
                    "startLine": 12
                }
            }
        ],
        "line_range": {
            "endLine": 20,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_vlan_proper_type_is_used_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_network_vlan",
            "test_vlan"
        ],
        "Attributes": {
            "child_resource_count": "self.child_resource_count",
            "datacenter": "dal06",
            "id": "self.id",
            "name": "test_vlan",
            "router_hostname": "fcr01a.dal06",
            "softlayer_managed": "self.softlayer_managed",
            "tags": [
                "collectd",
                "mesos-master"
            ],
            "type": "NONE"
        },
        "Blocks": [
            {
                "Type": "subnets",
                "Labels": [],
                "Attributes": {
                    "cidr": "",
                    "gateway": "1.3.4.5/2",
                    "subnet": "1.3.4.5/2",
                    "subnet_size": "24",
                    "subnet_type": "PRIMARY",
                    "vlan_number": "123"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 19,
                    "startLine": 12
                }
            }
        ],
        "line_range": {
            "endLine": 20,
            "startLine": 1
        }
    }]
	count(result) == 1
}
