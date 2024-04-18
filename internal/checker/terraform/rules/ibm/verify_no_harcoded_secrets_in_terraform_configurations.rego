# METADATA
# title: "Verify no hardcoded secrets in Terraform configurations"
# description: "This policy rule aims to enforce the absence of hardcoded secrets, like passwords or access keys, directly within Terraform configuration files, ensuring a more secure infrastructure deployment process."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/app
# custom:
#   id: CB_TFIBM_007
#   severity: HIGH
package lib.terraform.CB_TFIBM_007
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "ibm_app"
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
    some value in block.Attributes.environment_json
    command := block.Attributes.command
    regex_pattern := "^[a-zA-Z0-9]"
    regex.match(regex_pattern, command)
    regex.match(regex_pattern, value)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "No hard coded secrets found in Terraform configurations.",
		"snippet": block
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Hard coded secrets found in Terraform configurations.",
		"snippet": block,
	}
}
