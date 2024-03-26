# METADATA
# title: "Verify that CodeBuild project environments have a logging configuration"
# description: "By enabling comprehensive logging configurations for AWS CodeBuild projects, developers can gain valuable insights into build processes, identify potential issues, and monitor build performance efficiently, facilitating better troubleshooting and continuous improvement in the software development lifecycle."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project
# custom:
#   id: CB_TFAWS_301
#   severity: LOW
package lib.terraform.CB_TFAWS_301

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
	resource.Blocks[_].Type == "logs_config"
	resource.Blocks[_].Blocks[_].Type == "cloudwatch_logs"
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	resource.Blocks[_].Type == "logs_config"
	resource.Blocks[_].Blocks[_].Type == "s3_logs"
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "CodeBuild project environments have a logging configuration.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "CodeBuild project environments must have a logging configuration.",
		"snippet": block,
	}
}
