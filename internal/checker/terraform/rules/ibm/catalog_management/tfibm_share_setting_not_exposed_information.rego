# METADATA
# title: "Verify sharing settings do not expose sensitive information"
# description: "This policy establishes safeguards to protect sensitive information by meticulously examining resource sharing settings. By enforcing restrictions that prevent sharing with external parties and IBM, it ensures that confidential data remains securely contained within the organization's boundaries."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_offering
# custom:
#   id: CB_TFIBM_015
#   severity: HIGH
package lib.terraform.CB_TFIBM_015

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cm_offering", "cm_offering"]
	label in supported_resource
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
	attribute := resource.Attributes
	attribute.share_enabled == false
	attribute.share_with_all == false
	attribute.share_with_ibm == false
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Sharing settings does not expose sensitive information",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Sharing settings should not expose sensitive information",
		"snippet": block,
	}
}