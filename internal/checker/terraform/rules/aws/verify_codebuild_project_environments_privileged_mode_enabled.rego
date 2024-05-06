# METADATA
# title: "Verify that CodeBuild project environments do not have privileged mode enabled"
# description: "By disabling privileged mode in CodeBuild project environments, we ensure that the build process operates within a more secure and controlled context, reducing the risk of unauthorized access or malicious activities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project
# custom:
#   id: CB_TFAWS_302
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_302

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_codebuild_project"
}

has_attribute(key, value) if {
	value in object.keys(key)
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
	resource.Blocks[_].Type == "environment"
	resource.Blocks[_].Attributes.privileged_mode == true
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "CodeBuild project environments do not have privileged mode enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "CodeBuild project environments must not have privileged mode enabled.",
		"snippet": block,
	}
}
