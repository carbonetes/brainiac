# METADATA
# title: "Verify app path is encrypted"
# description: "This policy aims to verify that the application path is encrypted, ensuring enhanced security measures within the Terraform configurations."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/app
# custom:
#   id: CB_TFIBM_010
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_010
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

pass contains block if {
    some block in input
    isvalid(block)
	path := block.Attributes.app_path
	path != ""
    endswith(path, ".zip")
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "App Path is encrytped",
		"snippet": block
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "App Path is not encrypted",
		"snippet": block,
	}
}
