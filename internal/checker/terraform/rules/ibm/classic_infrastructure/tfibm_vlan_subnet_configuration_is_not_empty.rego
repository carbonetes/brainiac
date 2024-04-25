# METADATA
# title: "Verify subnet configuration is not empty"
# description: "This policy ensures that subnet configurations are complete and not empty, reducing the risk of network misconfigurations and vulnerabilities. It validates the presence of essential parameters such as CIDR, gateway, and subnet within each subnet entry of the input." 
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/network_vlan
# custom:
#   id: CB_TFIBM_078
#   severity: MEDIUM 
package lib.terraform.CB_TFIBM_078

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
	some block in resource.Blocks
	attribute := block.Attributes
	attribute.cidr != ""
    attribute.gateway != ""
    attribute.subnet != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Subnet is configured",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Subnet is not configured",
		"snippet": block,
	}
}