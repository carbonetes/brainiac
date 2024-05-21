# METADATA
# title: "Verify project ID is set properly"
# description: "This policy enforces constraints on the project id attribute to ensure its format integrity, helping maintain proper access control within the IBM Code Engine environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/code_engine_binding
# custom:
#   id: CB_TFIBM_103
#   severity: HIGH
package lib.terraform.CB_TFIBM_103
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
    pattern := "^[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}$"
    block := resource.Attributes
    "project_id" in object.keys(block)
    proj_id := block.project_id
    regex.match(pattern, proj_id)
}

passed contains result if {
	some block in pass
	result := {
		"message": "Project ID is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Project ID is not set properly.",
		"snippet": block,
	}
}
