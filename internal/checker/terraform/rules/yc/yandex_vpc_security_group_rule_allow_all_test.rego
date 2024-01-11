package lib.terraform.CB_TFYC_020

test_yandex_vpc_security_group_rule_allow_all_passed { 
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_vpc_network",
            "lab-net"
        ],
        "Attributes": {
            "name": "lab-network"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_vpc_security_group",
            "group1"
        ],
        "Attributes": {
            "description": "description for my security group",
            "labels": {
                "my-label": "my-label-value"
            },
            "name": "My security group",
            "network_id": "yandex_vpc_network.lab-net.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 5
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_vpc_security_group_rule",
            "rule1"
        ],
        "Attributes": {
            "description": "rule1 description",
            "direction": "ingress",
            "port": "8080",
            "protocol": "TCP",
            "security_group_binding": "yandex_vpc_security_group.group1.id",
            "v4_cidr_blocks": [
                "10.0.1.0/24",
                "10.0.2.0/24"
            ],
            "from_port": "1",
            "to_port": "16"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 22,
            "startLine": 15
        }
    }]
	count(result) == 1
}

test_yandex_vpc_security_group_rule_allow_all_failed { 
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_vpc_network",
            "lab-net"
        ],
        "Attributes": {
            "name": "lab-network"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_vpc_security_group",
            "group1"
        ],
        "Attributes": {
            "description": "description for my security group",
            "labels": {
                "my-label": "my-label-value"
            },
            "name": "My security group",
            "network_id": "yandex_vpc_network.lab-net.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 5
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_vpc_security_group_rule",
            "rule1"
        ],
        "Attributes": {
            "description": "rule1 description",
            "direction": "ingress",
            "port": "-1",
            "protocol": "TCP",
            "security_group_binding": "yandex_vpc_security_group.group1.id",
            "v4_cidr_blocks": [
                "10.0.1.0/24",
                "10.0.2.0/24",
                "0.0.0.0/0"
            ],
            "from_port": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 22,
            "startLine": 15
        }
    }]
	count(result) == 1
}