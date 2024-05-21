# METADATA
# title: "Verify proper VLAN type is used"
# description: "This policy helps prevent misconfigurations that could potentially compromise network integrity or expose sensitive information." 
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/network_vlan
# custom:
#   id: CB_TFIBM_084
#   severity: LOW 
package lib.terraform.CB_TFIBM_084

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_network_vlan", "test_vlan"]
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
    value := ["PUBLIC", "PRIVATE"]
    attribute.type in value
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "VLAN type is configured",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Undefined VLAN type",
		"snippet": block,
	}
}