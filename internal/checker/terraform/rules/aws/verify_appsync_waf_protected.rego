# METADATA
# title: "Verify AppSync is protected by WAF"
# description: "This measure prevents unauthorized access and helps maintain the integrity of data and resources within the AppSync APIs."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_graphql_api.html
# custom:
#   id: CB_TFAWS_335
#   severity: HIGH
package lib.terraform.CB_TFAWS_335

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_appsync_graphql_api"
}

getappsynclabel contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_appsync_graphql_api" in resource.Labels
	label := concat(".", resource.Labels)
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

is_attachement_valid if {
	some resource in input
	resource.Type == "resource"
	"aws_wafv2_web_acl_association" in resource.Labels
	some label in getappsynclabel
	contains(resource.Attributes.resource_arn, label)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_attachement_valid
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "AppSync is protected by WAF.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "AppSync should be protected by WAF.",
		"snippet": block,
	}
}
