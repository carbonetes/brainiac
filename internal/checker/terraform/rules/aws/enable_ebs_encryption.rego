# METADATA
# title: "Ensure all data stored in the EBS is securely encrypted"
# description: "This ensures that all EBS volumes are encrypted by default."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_encryption_by_default
# custom:
#   id: CB_TFAWS_003
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_003

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_ebs_volume"
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
	resource.Attributes.encrypted == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_ebs_volume' 'encrypted' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_ebs_volume' 'encrypted' should be set to true",
		"snippet": block,
	}
}
