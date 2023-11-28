# METADATA
# title: "The Alibaba Cloud OSS bucket is expected to be configured as private"
# description: "Verify that the Alibaba Cloud OSS bucket is configured with appropriate security measures by confirming it is set to private access, preventing unauthorized public access to sensitive data stored within the bucket."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket
# custom:
#   id: CB_TFALI_001
#   severity: LOW
package lib.terraform.CB_TFALI_001

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_oss_bucket" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[block] {
	some block in input
	isvalid(block)
	restricted_values := ["public-read", "public-read-write"]
	block.Attributes.acl in restricted_values
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Alibaba Cloud OSS bucket is set to private access.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Alibaba Cloud OSS bucket is not set to private access.",
		"snippet": block,
	}
}
