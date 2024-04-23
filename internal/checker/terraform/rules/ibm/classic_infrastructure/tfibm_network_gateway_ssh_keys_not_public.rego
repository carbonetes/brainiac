# METADATA
# title: "Verify SSH keys are not publicly accessible"
# description: "This policy aims to safeguard the security of SSH keys by preventing their exposure to the public domain. It systematically evaluates each SSH key within the designated scope to ascertain if it is configured for private access." 
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/network_gateway
# custom:
#   id: CB_TFIBM_075
#   severity: HIGH 
package lib.terraform.CB_TFIBM_075

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_network_gateway", "gateway"]
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
	attribute := block.Attributes
    attribute.private_network_only == true
    "ssh_key_ids" in object.keys(attribute)  
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "SSH keys are not publicly accessible",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "SSH keys must not publicly accessible",
		"snippet": block,
	}
}