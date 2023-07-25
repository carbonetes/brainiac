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

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "aws_codecommit_approval_rule_template"
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

pass[resource] {
	resource := input[_]
	isvalid(resource)
	contentPropStr := resource.Attributes.content
	contentParsed := json.unmarshal(contentPropStr)
	to_number(contentParsed.Statements[_].NumberOfApprovalsNeeded) >= 2
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "AWS codecommit branch changes have at least 2 approvals.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "AWS codecommit branch must have at least 2 approvals.",
		"snippet": block,
	}
}
