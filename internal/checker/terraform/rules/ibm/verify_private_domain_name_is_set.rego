# METADATA
# title: "Verify Private Domain name is set"
# description: "This policy verifies whether the specified Private Domain name is set within the IBM Cloud environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/app_domain_private
# custom:
#   id: CB_TFIBM_019
#   severity: LOW
package lib.terraform.CB_TFIBM_019
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "ibm_app_domain_private"
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
    name := resource.Attributes.name
    name != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Private domain name is set",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Private domain name is not set",
		"snippet": block,
	}
}