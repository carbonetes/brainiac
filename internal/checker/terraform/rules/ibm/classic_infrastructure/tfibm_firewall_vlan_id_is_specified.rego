# METADATA
# title: "Verify that public VLAN ID is specified"
# description: "This policy ensures that a public VLAN ID is specified in network configuration. Without it, there's a risk of connectivity issues and security vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/firewall
# custom:
#   id: CB_TFIBM_095
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_095

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_firewall", "testfw"]
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
    attribute.public_vlan_id != ""
    not regex.match(`[A-Z]+`, attribute.public_vlan_id)
	not regex.match(`[a-z]+`, attribute.public_vlan_id)
	not regex.match(`[_\-|@.,?/!~#$%^&*(){}\[\]=]+`, attribute.public_vlan_id)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "VLAN id is specified",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "VLAN id is not specified",
		"snippet": block,
	}
}