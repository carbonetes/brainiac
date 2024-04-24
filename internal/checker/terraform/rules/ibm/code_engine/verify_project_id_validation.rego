# METADATA
# title: "Verify project ID validation"
# description: "This policy validates the format of the project ID to meet the specified constraints."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/code_engine_secret
# custom:
#   id: CB_TFIBM_072
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_072
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
    label == "ibm_code_engine_secret"
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
    block := resource.Attributes
    "project_id" in object.keys(block)
    pattern := `^[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}$`
    regex.match(pattern, block.project_id)
}

passed contains result if {
	some block in pass
	result := {
		"message": "Project ID format is valid.", 
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Project ID format is not valid.",
		"snippet": block,
	}
}
