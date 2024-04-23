# METADATA
# title: "Verify sensitive data is not transmitted through environment variables"
# description: "This policy ensures that sensitive data remains secure by verifying that it is not transmitted through environment variables. By adhering to this practice, the system maintains confidentiality and integrity, minimizing potential security risks associated with exposing sensitive information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_validation
# custom:
#   id: CB_TFIBM_030
#   severity: HIGH
package lib.terraform.CB_TFIBM_030

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cm_validation", "cm_version_validation"]
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
	envi := attribute.environment_variables
	envi.secure == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Sensitive data isn't being transmitted via environment variables",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Sensitive data should not be transmitted via environment variables",
		"snippet": block,
	}
}