# METADATA
# title: "Verify codecommit branch changes have at least 2 approvals"
# description: "This practice helps catch potential issues, improves code readability, and encourages adherence to coding standards and best practices."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codecommit_approval_rule_template
# custom:
#   id: CB_TFAWS_239
#   severity: LOW
package lib.terraform.CB_TFAWS_239
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_codecommit_approval_rule_template"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if {
    some resource in input
	isvalid(resource)
	content_prop_str := resource.Attributes.content
	content_parsed := json.unmarshal(content_prop_str)
	to_number(content_parsed.Statements[_].NumberOfApprovalsNeeded) >= 2
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
    some block in pass
	result := {
		"message": "AWS codecommit branch changes have at least 2 approvals.",
		"snippet": block,
	}
}

failed contains result if {
    some block in fail
	result := {
		"message": "AWS codecommit branch must have at least 2 approvals.",
		"snippet": block,
	}
}
