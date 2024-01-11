package lib.terraform.CB_TFYC_019

test_yandex_vpc_security_group_allow_all_passed {
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
        "Blocks": [
            {
                "Type": "ingress",
                "Labels": [],
                "Attributes": {
                    "description": "rule1 description",
                    "port": "8080",
                    "protocol": "TCP",
                    "v4_cidr_blocks": [
                        "10.0.1.0/24",
                        "10.0.2.0/24"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 19,
                    "startLine": 14
                }
            },
            {
                "Type": "egress",
                "Labels": [],
                "Attributes": {
                    "description": "rule2 description",
                    "from_port": "8090",
                    "protocol": "ANY",
                    "to_port": "8099",
                    "v4_cidr_blocks": [
                        "10.0.1.0/24",
                        "10.0.2.0/24"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 27,
                    "startLine": 21
                }
            },
            {
                "Type": "egress",
                "Labels": [],
                "Attributes": {
                    "description": "rule3 description",
                    "from_port": "8090",
                    "protocol": "UDP",
                    "to_port": "8099",
                    "v4_cidr_blocks": [
                        "10.0.1.0/24"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 35,
                    "startLine": 29
                }
            }
        ],
        "line_range": {
            "endLine": 36,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_yandex_vpc_security_group_allow_all_failed {
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
        "Blocks": [
            {
                "Type": "ingress",
                "Labels": [],
                "Attributes": {
                    "description": "rule1 description",
                    "port": "-1",
                    "protocol": "TCP",
                    "v4_cidr_blocks": [
                        "0.0.0.0/0",
                        "10.0.2.0/24"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 19,
                    "startLine": 14
                }
            },
            {
                "Type": "egress",
                "Labels": [],
                "Attributes": {
                    "description": "rule2 description",
                    "from_port": "8090",
                    "protocol": "ANY",
                    "to_port": "8099",
                    "v4_cidr_blocks": [
                        "10.0.1.0/24",
                        "10.0.2.0/24"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 27,
                    "startLine": 21
                }
            },
            {
                "Type": "egress",
                "Labels": [],
                "Attributes": {
                    "description": "rule3 description",
                    "from_port": "8090",
                    "protocol": "UDP",
                    "to_port": "8099",
                    "v4_cidr_blocks": [
                        "10.0.1.0/24"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 35,
                    "startLine": 29
                }
            }
        ],
        "line_range": {
            "endLine": 36,
            "startLine": 5
        }
    }]
	count(result) == 1
}