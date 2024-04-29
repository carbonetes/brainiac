package lib.terraform.CB_TFIBM_075

import rego.v1

test_network_gateway_ssh_key_not_public_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_network_gateway",
            "gateway"
        ],
        "Attributes": {
            "name": "my-gateway",
            "private_ip_address_id": "private_ip_id",
            "private_ipv4_address": "10.0.0.1",
            "private_vlan_id": "private_vlan_id",
            "public_ip_address_id": "public_ip_id",
            "public_ipv4_address": "192.0.2.1",
            "public_ipv6_address_id": "public_ipv6_id",
            "public_vlan_id": "public_vlan_id",
            "status": "active"
        },
        "Blocks": [
            {
                "Type": "members",
                "Labels": [],
                "Attributes": {
                    "datacenter": "ams01",
                    "disk_key_names": [
                        "HARD_DRIVE_2_00TB_SATA_II"
                    ],
                    "domain": "ibm.com",
                    "hostname": "host-name",
                    "ipv6_enabled": true,
                    "memory": "8",
                    "network_speed": "100",
                    "notes": "gateway notes 1",
                    "os_key_name": "OS_VYATTA_5600_5_X_UP_TO_1GBPS_SUBSCRIPTION_EDITION_64_BIT",
                    "private_network_only": true,
                    "process_key_name": "INTEL_SINGLE_XEON_1270_3_50",
                    "public_bandwidth": "20000",
                    "redundant_network": false,
                    "ssh_key_ids": [
                        "ssh_key1",
                        "ssh_key2"
                    ],
                    "tags": [
                        "gateway tags 1",
                        "terraform test tags 1"
                    ],
                    "tcp_monitoring": true
                },
                "Blocks": [
                    {
                        "Type": "storage_groups",
                        "Labels": [],
                        "Attributes": {
                            "array_size": "1000",
                            "array_type_id": "12345",
                            "hard_drives": [
                                "hard_drive1",
                                "hard_drive2"
                            ],
                            "partition_template_id": "54321",
                            "ssh_key_ids": [
                                "ssh_key1",
                                "ssh_key2"
                            ],
                            "tags": [
                                "storage tags"
                            ],
                            "tcp_monitoring": true,
                            "unbonded_network": false,
                            "user_metadata": "user metadata"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 31,
                            "startLine": 21
                        }
                    },
                    {
                        "Type": "associated_vlans",
                        "Labels": [],
                        "Attributes": {
                            "bypass": "bypass_mode",
                            "network_vlan_id": "network_vlan_id",
                            "vlan_id": "vlan_id"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 39,
                            "startLine": 35
                        }
                    }
                ],
                "line_range": {
                    "endLine": 40,
                    "startLine": 4
                }
            }
        ],
        "line_range": {
            "endLine": 50,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_network_gateway_ssh_key_not_public_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_network_gateway",
            "gateway"
        ],
        "Attributes": {
            "name": "my-gateway",
            "private_ip_address_id": "private_ip_id",
            "private_ipv4_address": "10.0.0.1",
            "private_vlan_id": "private_vlan_id",
            "public_ip_address_id": "public_ip_id",
            "public_ipv4_address": "192.0.2.1",
            "public_ipv6_address_id": "public_ipv6_id",
            "public_vlan_id": "public_vlan_id",
            "status": "active"
        },
        "Blocks": [
            {
                "Type": "members",
                "Labels": [],
                "Attributes": {
                    "datacenter": "ams01",
                    "disk_key_names": [
                        "HARD_DRIVE_2_00TB_SATA_II"
                    ],
                    "domain": "ibm.com",
                    "hostname": "host-name",
                    "ipv6_enabled": true,
                    "memory": "8",
                    "network_speed": "100",
                    "notes": "gateway notes 1",
                    "os_key_name": "OS_VYATTA_5600_5_X_UP_TO_1GBPS_SUBSCRIPTION_EDITION_64_BIT",
                    "private_network_only": false,
                    "process_key_name": "INTEL_SINGLE_XEON_1270_3_50",
                    "public_bandwidth": "20000",
                    "redundant_network": false,
                    "ssh_key_ids": [
                        "ssh_key1",
                        "ssh_key2"
                    ],
                    "tags": [
                        "gateway tags 1",
                        "terraform test tags 1"
                    ],
                    "tcp_monitoring": true
                },
                "Blocks": [
                    {
                        "Type": "storage_groups",
                        "Labels": [],
                        "Attributes": {
                            "array_size": "1000",
                            "array_type_id": "12345",
                            "hard_drives": [
                                "hard_drive1",
                                "hard_drive2"
                            ],
                            "partition_template_id": "54321",
                            "ssh_key_ids": [
                                "ssh_key1",
                                "ssh_key2"
                            ],
                            "tags": [
                                "storage tags"
                            ],
                            "tcp_monitoring": true,
                            "unbonded_network": false,
                            "user_metadata": "user metadata"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 31,
                            "startLine": 21
                        }
                    },
                    {
                        "Type": "associated_vlans",
                        "Labels": [],
                        "Attributes": {
                            "bypass": "bypass_mode",
                            "network_vlan_id": "network_vlan_id",
                            "vlan_id": "vlan_id"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 39,
                            "startLine": 35
                        }
                    }
                ],
                "line_range": {
                    "endLine": 40,
                    "startLine": 4
                }
            }
        ],
        "line_range": {
            "endLine": 50,
            "startLine": 1
        }
    }]
	count(result) == 1
}
