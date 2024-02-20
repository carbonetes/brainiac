package lib.terraform.CB_TFRAN_085

test_rancher2_machine_config_v2_configuration_passed {
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
                "Type": "amazonec2_config",
                "Labels": [],
                "Attributes": {
                    "ami": "<AMI_ID>",
                    "region": "<REGION>",
                    "security_group": "[<AWS_SG>]",
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
            "endLine": 12,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_machine_config_v2_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_machine_config_v2",
            "foo"
        ],
        "Attributes": {
            "generate_name": ""
        },
        "Blocks": [
            {
                "Type": "amazonec2_config",
                "Labels": [],
                "Attributes": {
                    "ami": "<AMI_ID>",
                    "region": "<REGION>",
                    "security_group": "[<AWS_SG>]",
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
            "endLine": 12,
            "startLine": 2
        }
    }]
    count(result) == 1
}