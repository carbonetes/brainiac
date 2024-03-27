# METADATA
# title: "Make certain that CodeBuild projects are CMK-encrypted"
# description: "Your data is more secure from illegal access or manipulation when your CodeBuild projects are encrypted. By doing this, you can make sure that only people with the proper permissions can view and change the contents of your projects."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rgeraskin/aws3/latest/docs/resources/codebuild_project
# custom:
#   id: CB_TFAWS_122
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_122

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

pass contains resource if {
	some resource in input
	isvalid(resource)
	has_attribute(resource.Attributes, "encryption_key")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_codebuild_project' is encrypted.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_codebuild_project' should be encrypted.",
		"snippet": block,
	}
}