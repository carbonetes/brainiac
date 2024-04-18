# METADATA
# title: "Verify deprecate for offering is disabled"
# description: "This policy prohibits the use of deprecated features by denying any input marked as deprecated. By doing so, it ensures system integrity and longevity, mitigating potential risks associated with outdated functionalities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_offering
# custom:
#   id: CB_TFIBM_017
#   severity: LOW
package lib.terraform.CB_TFIBM_017

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

fail contains resource if {
	some resource in input
	attribute := resource.Attributes
	attribute.deprecate == true
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Offering deprecate is disabled",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Offering deprecate should be disabled",
		"snippet": block,
	}
}
