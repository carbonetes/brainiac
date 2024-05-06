# METADATA
# title: "Enable CloudTrail log file validation"
# description: "CloudTrail log file validation helps ensure the integrity of your log files. When log file integrity validation is enabled, CloudTrail validates the integrity of log files delivered to your S3 bucket. CloudTrail uses industry standard algorithms: SHA-256 for hashing and SHA-256 with RSA for digital signing. CloudTrail uses a hash file to validate the integrity of compressed log files."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail
# custom:
#   id: CB_TFAWS_033
#   severity: LOW
package lib.terraform.CB_TFAWS_033

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_cloudtrail"
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
	resource.Attributes.enable_log_file_validation == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_cloudtrail' 'enable_log_file_validation' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_cloudtrail' 'enable_log_file_validation' should be set to 'true'",
		"snippet": block,
	}
}
