# METADATA
# title: "Verify that CodeBuild Project encryption is not disabled"
# description: "Enabling encryption for CodeBuild projects helps maintain the confidentiality and integrity of your build artifacts and sensitive information, providing an additional layer of security for your software development and deployment processes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project
# custom:
#   id: CB_TFAWS_086
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_086

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_codebuild_project"
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
	some block in resource.Blocks
	block.Type == "artifacts"
	block.Attributes.encryption_disabled == false
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_codebuild_project' encryption is not disabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_codebuild_project' encryption should not be disabled",
		"snippet": block,
	}
}