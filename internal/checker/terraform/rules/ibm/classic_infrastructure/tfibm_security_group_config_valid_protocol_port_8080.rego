# METADATA
# title: "Verify configuration for valid protocols on Port 8080"
# description: "This policy ensures that only valid protocols are allowed for inbound traffic on port 8080. It verifies adherence to security best practices and helps prevent potential vulnerabilities or service disruptions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/security_group_rule
# custom:
#   id: CB_TFIBM_085
#   severity: HIGH
package lib.terraform.CB_TFIBM_085

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_security_group_rule", "allow_port_8080"]
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
	direction_value := ["ingress", "egress"]
    attribute.direction in direction_value
}

fail contains block if {
	some block in input
	isvalid(block)
    attribute := block.Attributes
    allowed := ["8080"]
    not attribute.port_range_max in allowed
}

fail contains block if {
	some block in input
	isvalid(block)
    attribute := block.Attributes
    allowed := ["8080"]
    not attribute.port_range_min in allowed
}

fail contains block if {
	some block in input
	isvalid(block)
    attribute := block.Attributes
    allowed := ["tcp", "udp", "icmp"]
    not attribute.protocol in allowed
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Port 8080 is configured",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Port 8080 is not configured",
		"snippet": block,
	}
}