# METADATA
# title: "Verify vpx connection limit is set"
# description: "This policy verifies whether the connection limit for a service is set within an acceptable range promoting security best practices." 
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/lb_vpx_service
# custom:
#   id: CB_TFIBM_069
#   severity: MEDIUM    
package lib.terraform.CB_TFIBM_069

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_lb_vpx_service", "test_service"]
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

second(attribute) if {
	attribute.secondary_id != ""
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	attribute := resource.Attributes
	"connection_limit" in object.keys(attribute)
    attribute.connection_limit <= 4294967294
    not regex.match(`[A-Z]+`, attribute.connection_limit)
	not regex.match(`[a-z]+`, attribute.connection_limit)
	not regex.match(`[_\-|@.,?/!~#$%^&*(){}\[\]=]+`, attribute.connection_limit)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Connection limit is set within acceptable range",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Connection limit is too high",
		"snippet": block,
	}
}