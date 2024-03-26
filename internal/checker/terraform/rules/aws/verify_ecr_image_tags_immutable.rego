# METADATA
# title: "Verify ECR Image Tags are immutable"
# description: "Immutable tags can help prevent unauthorized or malicious changes to your container images, as well as reduce the risk of accidental or unintended changes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository
# custom:
#   id: CB_TFAWS_049
#   severity: LOW
package lib.terraform.CB_TFAWS_049

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_ecr_repository"
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
	resource.Attributes.image_tag_mutability == "IMMUTABLE"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_ecr_repository' 'image_tag_mutability' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_kms_key' 'image_tag_mutability' should be set to 'IMMUTABLE'",
		"snippet": block,
	}
}