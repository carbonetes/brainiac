# METADATA
# title: "Verify MongoDB Deployment within a Virtual Private Cloud (VPC)"
# description: "This policy ensures that MongoDB instances are deployed securely within a Virtual Private Cloud (VPC). Deploying MongoDB within a VPC enhances network isolation and security."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/mongodb_instance
# custom:
#   id: CB_TFALI_038
#   severity: LOW
package lib.terraform.CB_TFALI_038

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_mongodb_instance" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.network_type == "VPC"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The MongoDB deployment is configured within a Virtual Private Cloud (VPC), ensuring enhanced network isolation and security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The MongoDB deployment is not within a Virtual Private Cloud (VPC), posing potential security risks. Adjust the configuration to place MongoDB within a VPC.",
		"snippet": block,
	}
}
