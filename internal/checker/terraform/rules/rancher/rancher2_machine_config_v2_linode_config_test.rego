package lib.terraform.CB_TFRAN_137

test_rancher2_machine_config_v2_linode_config_passed {
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
            "endLine": 13,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_machine_config_v2_linode_config_failed {
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
            },
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
            "endLine": 13,
            "startLine": 2
        }
    }]
    count(result) == 1
}