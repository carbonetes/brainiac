package lib.terraform.CB_TFRAN_138

test_rancher2_machine_config_v2_openstack_config_passed {
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
                "Type": "openstack_config",
                "Labels": [],
                "Attributes": {
                    "auth_url": "<OPENSTACK_AUTH_URL>",
                    "availability_zone": "<OPENSTACK_AVAILABILITY_ZONE>",
                    "domain_name": "<OPENSTACK_DOMAIN_NAME>",
                    "flavor_name": "<OPENSTACK_FLAVOR_NAME>",
                    "image_name": "<OPENSTACK_IMAGE_NAME>",
                    "net_name": "<OPENSTACK_NET_NAME>",
                    "region": "<OPENSTACK_REGION>",
                    "tenant_domain_name": "<OPENSTACK_TENANT_DOMAIN_NAME>",
                    "tenant_name": "<OPENSTACK_TENANT_NAME>",
                    "user_domain_name": "<OPENSTACK_USER_DOMAIN_NAME>",
                    "username": "<OPENSTACK_USERNAME>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 18,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_machine_config_v2_openstack_config_failed {
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
                "Type": "openstack_config",
                "Labels": [],
                "Attributes": {
                    "auth_url": "<OPENSTACK_AUTH_URL>",
                    "availability_zone": "<OPENSTACK_AVAILABILITY_ZONE>",
                    "domain_name": "<OPENSTACK_DOMAIN_NAME>",
                    "flavor_name": "<OPENSTACK_FLAVOR_NAME>",
                    "image_name": "<OPENSTACK_IMAGE_NAME>",
                    "net_name": "<OPENSTACK_NET_NAME>",
                    "region": "<OPENSTACK_REGION>",
                    "tenant_domain_name": "<OPENSTACK_TENANT_DOMAIN_NAME>",
                    "tenant_name": "<OPENSTACK_TENANT_NAME>",
                    "user_domain_name": "<OPENSTACK_USER_DOMAIN_NAME>",
                    "username": "<OPENSTACK_USERNAME>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 5
                }
            },
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
            "endLine": 18,
            "startLine": 2
        }
    }]
    count(result) == 1
}