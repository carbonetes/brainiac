package lib.terraform.CB_TFRAN_147

test_rancher2_node_template_drivers_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "foo"
        ],
        "Attributes": {
            "description": "foo test",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "amazonec2_config",
                "Labels": [],
                "Attributes": {
                    "access_key": "AWS_ACCESS_KEY",
                    "ami": "<AMI_ID>",
                    "region": "<REGION>",
                    "secret_key": "<AWS_SECRET_KEY>",
                    "security_group": [
                        "<AWS_SECURITY_GROUP>"
                    ],
                    "subnet_id": "<SUBNET_ID>",
                    "vpc_id": "<VPC_ID>",
                    "zone": "<ZONE>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_node_template_drivers_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "foo"
        ],
        "Attributes": {
            "description": "foo test",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "not_supported_driver",
                "Labels": [],
                "Attributes": {
                    "access_key": "AWS_ACCESS_KEY",
                    "ami": "<AMI_ID>",
                    "region": "<REGION>",
                    "secret_key": "<AWS_SECRET_KEY>",
                    "security_group": [
                        "<AWS_SECURITY_GROUP>"
                    ],
                    "subnet_id": "<SUBNET_ID>",
                    "vpc_id": "<VPC_ID>",
                    "zone": "<ZONE>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 2
        }
    }]
    count(result) == 1
}