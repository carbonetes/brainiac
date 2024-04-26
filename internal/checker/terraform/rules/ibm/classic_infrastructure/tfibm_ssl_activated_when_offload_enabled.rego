# METADATA
# title: "Verify SSL is activated when SSL offload is enabled"
# description: "This policy ensures that the activation of SSL, which establishes secure communication, is dependent on the activation of SSL offload, a mechanism that delegates SSL processing tasks. It verifies that SSL encryption is only initiated when SSL offload functionality is enabled, aligning with best practices for secure network configurations."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/lb
# custom:
#   id: CB_TFIBM_058
#   severity: HIGH
package lib.terraform.CB_TFIBM_058

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_lb", "test_lb_local"]
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
	isvalid(resource)
	attribute := resource.Attributes
	attribute.ssl_enabled == false
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	attribute := resource.Attributes
	attribute.ssl_offload == false
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "SSL and offload is enabled",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "SSL or offload is not enabled",
		"snippet": block,
	}
}