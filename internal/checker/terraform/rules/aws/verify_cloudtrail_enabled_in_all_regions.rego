# METADATA
# title: "Verify CloudTrail is enabled in all Regions"
# description: "Enabling CloudTrail in all regions ensures that no AWS account activities go undocumented."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail
# custom:
#   id: CB_TFAWS_067
#   severity: LOW
package lib.terraform.CB_TFAWS_067

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_cloudtrail"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.is_multi_region_trail = true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_cloudwatch_log_group' 'is_multi_region_trail' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_cloudwatch_log_group' 'is_multi_region_trail' should be set.",
		"snippet": block,
	}
}
