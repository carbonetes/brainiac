package lib.terraform.CB_TFRAN_062

test_rancher2_cluster_aks_config_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "rancher2"
        ],
        "Attributes": {
            "api_url": "https://rancher.example.com",
            "token": "your-api-token"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 2
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "rancher2_cluster",
            "example_cluster"
        ],
        "Attributes": {
            "name": "example-cluster"
        },
        "Blocks": [
            {
                "Type": "aks_config",
                "Labels": [],
                "Attributes": {
                    "agent_dns_prefix": "example-agent-dns-prefix",
                    "client_id": "your-client-id",
                    "client_secret": "your-client-secret",
                    "docker_bridge_cidr": "172.17.0.1/16",
                    "kubernetes_version": "1.20.9",
                    "master_dns_prefix": "example-master-dns-prefix",
                    "resource_group": "example-resource-group",
                    "ssh_public_key_contents": "your-ssh-public-key-contents",
                    "subnet": "example-subnet",
                    "subscription_id": "your-subscription-id",
                    "tenant_id": "your-tenant-id",
                    "virtual_network": "example-virtual-network",
                    "virtual_network_resource_group": "example-virtual-network-resource-group"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 28,
                    "startLine": 14
                }
            }
        ],
        "line_range": {
            "endLine": 29,
            "startLine": 9
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_aks_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster",
            "foo-custom"
        ],
        "Attributes": {
            "description": "Foo rancher2 custom cluster",
            "name": "foo-custom"
        },
        "Blocks": [
            {
                "Type": "aks_config",
                "Labels": [],
                "Attributes": {
                    "agent_dns_prefix": "example-agent-dns-prefix",
                    "client_id": "your-client-id",
                    "client_secret": "your-client-secret",
                    "docker_bridge_cidr": "172.17.0.1/16",
                    "kubernetes_version": "1.20.9",
                    "master_dns_prefix": "example-master-dns-prefix",
                    "resource_group": "example-resource-group",
                    "ssh_public_key_contents": "your-ssh-public-key-contents",
                    "subnet": "example-subnet",
                    "subscription_id": "your-subscription-id",
                    "tenant_id": "your-tenant-id",
                    "virtual_network": "example-virtual-network",
                    "virtual_network_resource_group": "example-virtual-network-resource-group"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 28,
                    "startLine": 14
                }
            },
            {
                "Type": "aks_config_v2",
                "Labels": [],
                "Attributes": {
                    "cloud_credential_id": "rancher2_cloud_credential.foo-aks.id",
                    "imported": true,
                    "resource_group": "<RESOURCE_GROUP>",
                    "resource_location": "<RESOURCE_LOCATION>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 30,
                    "startLine": 25
                }
            }
        ],
        "line_range": {
            "endLine": 31,
            "startLine": 2
        }
    }]
    count(result) == 1
}
