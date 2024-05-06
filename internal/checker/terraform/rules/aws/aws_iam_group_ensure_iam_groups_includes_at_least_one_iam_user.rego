# METADATA
# title: "A minimum of one IAM user must be present in IAM groups"
# description: "A minimum of one IAM user should be present in each IAM group. When you need to assign particular activities or obligations to other users, this could be beneficial to verify that at least one person has the privileges connected to the group."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group.html
# custom:
#   id: CB_TFAWS_347
#   severity: LOW
package lib.terraform.CB_TFAWS_347

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_iam_group"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getthelabelforawsiamgroup contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_iam_group" in resource.Labels
	label := concat(".", resource.Labels)
}

getthelabelforawsiamuser contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_iam_user" in resource.Labels
	label := concat(".", resource.Labels)
}

is_valid_resource_attached if {
	some resource in input
	resource.Type == "resource"
	"aws_iam_group_membership" in resource.Labels
	some awsiamgrouplabel in getthelabelforawsiamgroup
	some awsiamuserlabel in getthelabelforawsiamuser
	contains(resource.Attributes.group, awsiamgrouplabel)
	contains(resource.Attributes.users, awsiamuserlabel)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "A minimum of one IAM user is present in IAM groups.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "For each IAM group, a minimum of one IAM user must be present.",
		"snippet": block,
	}
}
