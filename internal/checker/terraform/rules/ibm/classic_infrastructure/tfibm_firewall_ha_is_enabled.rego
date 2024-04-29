# METADATA
# title: "Verify that HA is enabled for firewall"
# description: "This policy requires enabling high availability (HA) for dedicated hardware firewalls to ensure uninterrupted protection against network threats and prevent downtime."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/firewall
# custom:
#   id: CB_TFIBM_089
#   severity: HIGH
package lib.terraform.CB_TFIBM_089

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
    attribute.ha_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Firewall HA is enabled",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Firewall HA is not enabled",
		"snippet": block,
	}
}