# METADATA
# title: "Verify SSM documents are not Public"
# description: "By restricting public access to SSM documents, Terraform helps maintain data security, compliance, and adherence to AWS security best practices."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/4.8.0/docs/data-sources/ssm_document
# custom:
#   id: CB_TFAWS_282
#   severity: HIGH
package lib.terraform.CB_TFAWS_282

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := ["aws_ssm_document", "aws_ssm_document_permission"]
	label in supported_resources
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	resource.Blocks[_].Type == "permissions"
	resource.Blocks[_].Attributes.account_ids == "All"
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.account_ids == "All"
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "SSM documents are not Public.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "SSM documents account_ids permissions should not be set to 'All'.",
		"snippet": block,
	}
}
