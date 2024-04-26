# METADATA
# title: "Verify security certificate ID is set"
# description: "This policy mandates that a valid and trustworthy security certificate ID must be provided. It ensures that the input for the security certificate ID is not empty, thereby maintaining the integrity and security of the system or data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/lb
# custom:
#   id: CB_TFIBM_052
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_052

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
	not "security_certificate_id" in object.keys(attribute)
    certificate := attribute.security_certificate_id
	regex.match(`[0-9]`, certificate)
    regex.match(`[A-Z]+`, certificate)
	regex.match(`[a-z]+`, certificate)
	regex.match(`[_\-|@.,?/!~#$%^&*(){}\[\]=]+`, certificate)
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Security certificate ID is set",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Security certificate ID is required",
		"snippet": block,
	}
}