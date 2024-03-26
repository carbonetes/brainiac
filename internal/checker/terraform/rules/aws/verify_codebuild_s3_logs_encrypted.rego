# METADATA
# title: "Verify that CodeBuild S3 logs are encrypted"
# description: "Verifying that CodeBuild S3 logs are encrypted enhances the security and confidentiality of build logs in AWS CodeBuild."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rgeraskin/aws3/latest/docs/resources/codebuild_project#encryption_disabled
# custom:
#   id: CB_TFAWS_294
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_294

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

fail contains resource if {
	some resource in input
	isvalid(resource)
	resource.Blocks[_].Type == "logs_config"
	resource.Blocks[_].Blocks[_].Type == "s3_logs"
	resource.Blocks[_].Blocks[_].Attributes.encryption_disabled == true
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "CodeBuild S3 logs are encrypted.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'s3_logs' encryption_disabled must be set to false.",
		"snippet": block,
	}
}
