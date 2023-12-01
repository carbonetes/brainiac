# METADATA
# title: "Verify Alibaba Cloud Load Balancer (ALB) ACL Restricts Access"
# description: "This policy checks whether Alibaba Cloud Load Balancer (ALB) Access Control List (ACL) is configured to restrict access. Restricting access through ACLs enhances security by controlling which clients or IP ranges can access the load balancer."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_acl_entry_attachment
# custom:
#   id: CB_TFALI_020
#   severity: LOW
package lib.terraform.CB_TFALI_020

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_alb_acl_entry_attachment" in block.Labels
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
	resource.Attributes.entry != "0.0.0.0/0"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "ALB ACL is configured to restrict access, enhancing security by controlling client or IP range access.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "ALB ACL does not restrict access. Configure ACLs to control access and improve security.",
		"snippet": block,
	}
}
