# METADATA
# title: "Verify Codecommit associates an approval rule"
# description: "This guarantees that authorized team members review and approve modifications, enhancing code quality and security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codecommit_approval_rule_template_association
# custom:
#   id: CB_TFAWS_344
#   severity: LOW
package lib.terraform.CB_TFAWS_344

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_codecommit_repository"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getcodecommitrepolabel contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_codecommit_repository" in resource.Labels
	label := concat(".", resource.Labels)
}

getiscodecommitapprovalattached if {
	some resource in input
	resource.Type == "resource"
	"aws_codecommit_approval_rule_template_association" in resource.Labels
	some label in getcodecommitrepolabel
	contains(resource.Attributes.repository_name, label)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	getiscodecommitapprovalattached
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Codecommit associates an approval rule.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Codecommit should associates an approval rule.",
		"snippet": block,
	}
}
