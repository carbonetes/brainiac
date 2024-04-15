# METADATA
# title: "Verify that trusted profiles are properly defined"
# description: "This policy requires validating the accurate configuration of trusted profiles. It ensures system integrity and security by verifying the proper definition of each trusted profile."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_catalog
# custom:
#   id: CB_TFIBM_005
#   severity: HIGH
package lib.terraform.CB_TFIBM_005

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cm_catalog", "cm_catalog"]
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
	some block in resource.Blocks
	some blocks in block.Blocks
	attribute := blocks.Attributes
	attribute.target_service_id != ""
	attribute.trusted_profile_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Trusted profiles are properly defined with valid IDs",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Trusted profiles is not properly defined",
		"snippet": block,
	}
}