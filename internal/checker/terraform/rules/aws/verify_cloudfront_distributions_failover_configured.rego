# METADATA
# title: "Verify CloudFront distributions should have origin failover configured"
# description: "Origin failover automatically switches to a backup origin if the primary one becomes unavailable, ensuring continuous content delivery during outages or disruptions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#origin_group
# custom:
#   id: CB_TFAWS_293
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_293

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_cloudfront_distribution"
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
	resource.Blocks[_].Type == "origin_group"
	resource.Blocks[_].Blocks[_].Type == "failover_criteria"
	count(count_member_types) > 1
}

count_member_types contains member if {
	some resource in input
	resource.Blocks[_].Type == "origin_group"
	member := resource.Blocks[_].Blocks[_]
	member.Type == "member"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "CloudFront distributions have origin failover configured.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "CloudFront distributions should have origin failover configured.",
		"snippet": block,
	}
}
