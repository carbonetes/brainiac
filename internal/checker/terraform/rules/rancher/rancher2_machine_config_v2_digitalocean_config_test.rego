package lib.terraform.CB_TFRAN_135

test_rancher2_machine_config_v2_digitalocean_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_machine_config_v2",
            "foo"
        ],
        "Attributes": {
            "generate_name": "test-foo"
        },
        "Blocks": [
            {
                "Type": "digitalocean_config",
                "Labels": [],
                "Attributes": {
                    "access_token": "<DIGITALOCEAN_ACCESS_TOKEN>",
                    "backups": false,
                    "image": "<DIGITALOCEAN_IMAGE>",
                    "ipv6": false,
                    "monitoring": false,
                    "region": "<DIGITALOCEAN_REGION>",
                    "size": "<DIGITALOCEAN_SIZE>",
                    "ssh_key_fingerprint": "<DIGITALOCEAN_SSH_KEY_FINGERPRINT>",
                    "tags": [
                        "<TAG1>",
                        "<TAG2>"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 15,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 16,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_machine_config_v2_digitalocean_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_machine_config_v2",
            "foo"
        ],
        "Attributes": {
            "generate_name": "test-foo"
        },
        "Blocks": [
            {
                "Type": "digitalocean_config",
                "Labels": [],
                "Attributes": {
                    "access_token": "<DIGITALOCEAN_ACCESS_TOKEN>",
                    "backups": false,
                    "image": "<DIGITALOCEAN_IMAGE>",
                    "ipv6": false,
                    "monitoring": false,
                    "region": "<DIGITALOCEAN_REGION>",
                    "size": "<DIGITALOCEAN_SIZE>",
                    "ssh_key_fingerprint": "<DIGITALOCEAN_SSH_KEY_FINGERPRINT>",
                    "tags": [
                        "<TAG1>",
                        "<TAG2>"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 15,
                    "startLine": 5
                }
            },
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
            "endLine": 16,
            "startLine": 2
        }
    }]
    count(result) == 1
}