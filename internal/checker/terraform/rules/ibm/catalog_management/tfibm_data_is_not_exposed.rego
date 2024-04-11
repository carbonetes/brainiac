# METADATA
# title: "Verify sensitive data is not exposed"
# description: "This policy safeguards against the inadvertent exposure of sensitive information within Terraform configurations. By verifying that confidential data remains concealed, it mitigates the potential risk of unauthorized access or misuse."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_object
# custom:
#   id: CB_TFIBM_006
#   severity: HIGH
package lib.terraform.CB_TFIBM_006

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cm_object", "cm_object"]
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
    block := resource.Attributes
    "data" in object.keys(block)
    block.data != ""
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Sensitive data is not exposed",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Sensitive data is exposed",
		"snippet": block,
	}
}
