# METADATA
# title: "Verify Encryption for Launch Template Data Disks"
# description: "This policy verifies whether data disks associated with launch templates are encrypted. Ensuring encryption adds an additional layer of security to sensitive data stored on these disks."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_launch_template
# custom:
#   id: CB_TFALI_031
#   severity: LOW
package lib.terraform.CB_TFALI_031

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_ecs_launch_template" in block.Labels
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
	some block in resource.Blocks
	block.Type == "data_disks"
   	block.Attributes.encrypted == "true"
}


fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Data disks for launch templates are encrypted, enhancing the security of stored data.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Launch template data disks are not encrypted. Enable encryption to enhance the security of stored data on these disks.",
		"snippet": block,
	}
}
