# METADATA
# title: "Verify timeout configuration is set"
# description: "This policy ensures that a valid timeout configuration is established. It verifies that a timeout value for the creation process is specified, enhancing the reliability and efficiency of the system."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/lb
# custom:
#   id: CB_TFIBM_059
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_059

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

offload(attribute) if {
	attribute.ssl_offload == true
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
    attribute := block.Attributes
    attribute.create != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Timeout config is set",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Timeout config is not set",
		"snippet": block,
	}
}