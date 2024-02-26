package lib.terraform.CB_TFRAN_136

test_rancher2_machine_config_v2_harvester_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_machine_config_v2",
            "foo-harvester-v2"
        ],
        "Attributes": {
            "generate_name": "foo-harvester-v2"
        },
        "Blocks": [
            {
                "Type": "harvester_config",
                "Labels": [],
                "Attributes": {
                    "cpu_count": "2",
                    "disk_info": "    {\r\n        \"disks\": [{\r\n            \"imageName\": \"harvester-public/image-57hzg\",\r\n            \"size\": 40,\r\n            \"bootOrder\": 1\r\n        }]\r\n    }\r\n",
                    "memory_size": "4",
                    "network_info": "    {\r\n        \"interfaces\": [{\r\n            \"networkName\": \"harvester-public/vlan1\"\r\n        }]\r\n    }\r\n",
                    "ssh_user": "ubuntu",
                    "user_data": "    package_update: true\r\n    packages:\r\n      - qemu-guest-agent\r\n      - iptables\r\n    runcmd:\r\n      - - systemctl\r\n        - enable\r\n        - '--now'\r\n        - qemu-guest-agent.service\r\n",
                    "vm_namespace": "default"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 36,
                    "startLine": 4
                }
            }
        ],
        "line_range": {
            "endLine": 37,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_machine_config_v2_harvester_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_machine_config_v2",
            "foo-harvester-v2"
        ],
        "Attributes": {
            "generate_name": "foo-harvester-v2"
        },
        "Blocks": [
            {
                "Type": "harvester_config",
                "Labels": [],
                "Attributes": {
                    "cpu_count": "2",
                    "disk_info": "    {\r\n        \"disks\": [{\r\n            \"imageName\": \"harvester-public/image-57hzg\",\r\n            \"size\": 40,\r\n            \"bootOrder\": 1\r\n        }]\r\n    }\r\n",
                    "memory_size": "4",
                    "network_info": "    {\r\n        \"interfaces\": [{\r\n            \"networkName\": \"harvester-public/vlan1\"\r\n        }]\r\n    }\r\n",
                    "ssh_user": "ubuntu",
                    "user_data": "    package_update: true\r\n    packages:\r\n      - qemu-guest-agent\r\n      - iptables\r\n    runcmd:\r\n      - - systemctl\r\n        - enable\r\n        - '--now'\r\n        - qemu-guest-agent.service\r\n",
                    "vm_namespace": "default"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 36,
                    "startLine": 4
                }
            },
            {
                "Type": "linode_config",
                "Labels": [],
                "Attributes": {
                    "image": "<LINODE_IMAGE>",
                    "instance_type": "<LINODE_INSTANCE_TYPE>",
                    "region": "<LINODE_REGION>",
                    "root_pass": "<LINODE_ROOT_PASSWORD>",
                    "ssh_user": "<LINODE_SSH_USER>",
                    "token": "<LINODE_API_TOKEN>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 12,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 37,
            "startLine": 2
        }
    }]
    count(result) == 1
}