# METADATA
# title: "Verify that EBS default encryption is active"
# description: Enabling encryption for data at rest minimizes the risk of unintended disclosure of data stored in EBS volumes."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_encryption_by_default
# custom:
#   id: CB_TFAWS_069
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_069

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_ebs_encryption_by_default"
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
	resource.Attributes.enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Default encryption for EBS is active.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Default encryption for EBS should be active.",
		"snippet": block,
	}
}