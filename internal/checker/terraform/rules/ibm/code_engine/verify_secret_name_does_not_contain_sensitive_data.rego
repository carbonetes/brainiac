# METADATA
# title: "Verify secret name does not contain sensitive data"
# description: "This policy ensures that the secret name attribute adheres to a naming convention and avoids directly exposing sensitive information by enforcing a specific prefix requirement."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/code_engine_binding
# custom:
#   id: CB_TFIBM_102
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_102
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
    label == "ibm_code_engine_binding"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains block if {
    some block in input
    isvalid(block)
    not pass[block]
}

pass contains resource if {
	some resource in input
	isvalid(resource)
    pattern := "^[a-z0-9]([\\-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([\\-a-z0-9]*[a-z0-9])?)*$"
    block := resource.Attributes
    "secret_name" in object.keys(block)
    name := block.secret_name
    regex.match(pattern, name)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
    count(resource.Attributes.secret_name) > 253
    resource.Attributes.secret_name != ""
}

passed contains result if {
	some block in pass
	result := {
		"message": "Secret name does not contain sensitive data.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Secret name does contain sensitive data.",
		"snippet": block,
	}
}
