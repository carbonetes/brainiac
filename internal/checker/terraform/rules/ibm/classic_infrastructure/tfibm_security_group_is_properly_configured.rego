# METADATA
# title: "Verify security group is properly configured"
# description: "This policy meticulously reviews the configuration of security group ID to confirm its alignment with security standards. By ensuring proper setup, it bolsters access control measures, diminishing the likelihood of unauthorized breaches and enhancing overall security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/security_group_rule
# custom:
#   id: CB_TFIBM_088
#   severity: HIGH
package lib.terraform.CB_TFIBM_088

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
    regex.match(`[0-9]+`, attribute.security_group_id)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	attribute := resource.Attributes
    attribute.security_group_id != ""
    not regex.match(`[A-Z]+`, attribute.security_group_id)
	not regex.match(`[a-z]+`, attribute.security_group_id)
	not regex.match(`[_\-|@.,?/!~#$%^&*(){}\[\]=]+`, attribute.security_group_id)
}

fail contains block if {
	some block in input
	isvalid(block)
    attribute := block.Attributes
    allowed := ["IPv4", "IPv6"]
    not attribute.ether_type in allowed
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Security group is properly configured",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Security group is not properly configured",
		"snippet": block,
	}
}