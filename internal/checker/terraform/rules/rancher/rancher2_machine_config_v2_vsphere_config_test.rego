package lib.terraform.CB_TFRAN_139

test_rancher2_machine_config_v2_vsphere_config_passed {
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
                "Type": "vsphere_config",
                "Labels": [],
                "Attributes": {
                    "cpu_count": "2",
                    "datacenter": "<VSPHERE_DATACENTER>",
                    "datastore": "<VSPHERE_DATASTORE>",
                    "disk_size": "20480",
                    "folder": "<VSPHERE_FOLDER>",
                    "memory_size": "2048",
                    "network": [
                        "<VSPHERE_NETWORK_1>",
                        "<VSPHERE_NETWORK_2>"
                    ],
                    "pool": "<VSPHERE_RESOURCE_POOL>",
                    "ssh_password": "tcuser",
                    "ssh_port": "22",
                    "ssh_user": "docker",
                    "vcenter": "<VSPHERE_VCENTER>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 18,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 19,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_machine_config_v2_vsphere_config_failed {
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
                "Type": "vsphere_config",
                "Labels": [],
                "Attributes": {
                    "cpu_count": "2",
                    "datacenter": "<VSPHERE_DATACENTER>",
                    "datastore": "<VSPHERE_DATASTORE>",
                    "disk_size": "20480",
                    "folder": "<VSPHERE_FOLDER>",
                    "memory_size": "2048",
                    "network": [
                        "<VSPHERE_NETWORK_1>",
                        "<VSPHERE_NETWORK_2>"
                    ],
                    "pool": "<VSPHERE_RESOURCE_POOL>",
                    "ssh_password": "tcuser",
                    "ssh_port": "22",
                    "ssh_user": "docker",
                    "vcenter": "<VSPHERE_VCENTER>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 18,
                    "startLine": 5
                }
            },
            {
                "Type": "amazonec2_config",
                "Labels": [],
                "Attributes": {
                    "ami": "<AMI_ID>",
                    "region": "<REGION>",
                    "security_group": [
                        "<AWS_SG>"
                    ],
                    "subnet_id": "<SUBNET_ID>",
                    "vpc_id": "<VPC_ID>",
                    "zone": "<ZONE>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 4
                }
            }
        ],
        "line_range": {
            "endLine": 19,
            "startLine": 2
        }
    }]
    count(result) == 1
}