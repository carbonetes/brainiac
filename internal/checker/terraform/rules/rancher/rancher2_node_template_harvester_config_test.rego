package lib.terraform.CB_TFRAN_152

test_rancher2_node_template_harvester_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "foo-harvester"
        ],
        "Attributes": {
            "cloud_credential_id": "rancher2_cloud_credential.foo-harvester.id",
            "engine_install_url": "https://releases.rancher.com/install-docker/20.10.sh",
            "name": "foo-harvester"
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
                    "endLine": 38,
                    "startLine": 6
                }
            }
        ],
        "line_range": {
            "endLine": 39,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_node_template_harvester_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "foo-harvester"
        ],
        "Attributes": {
            "cloud_credential_id": "rancher2_cloud_credential.foo-harvester.id",
            "engine_install_url": "https://releases.rancher.com/install-docker/20.10.sh",
            "name": "foo-harvester"
        },
        "Blocks": [
            {
                "Type": "harvester_config",
                "Labels": [],
                "Attributes": {
                    "cpu_count": "2",
                    "disk_info": "",
                    "memory_size": "4",
                    "network_info": "",
                    "ssh_user": "",
                    "user_data": "    package_update: true\r\n    packages:\r\n      - qemu-guest-agent\r\n      - iptables\r\n    runcmd:\r\n      - - systemctl\r\n        - enable\r\n        - '--now'\r\n        - qemu-guest-agent.service\r\n",
                    "vm_namespace": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 38,
                    "startLine": 6
                }
            }
        ],
        "line_range": {
            "endLine": 39,
            "startLine": 2
        }
    }]
    count(result) == 1
}