# METADATA
# title: "Verify source type for pipeline is git"
# description: "This policy ensures that the 'type' field in an IBM Terraform resource is set to "git", indicating a Git repository source"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cd_tekton_pipeline_definition
# custom:
#   id: CB_TFIBM_110
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_110

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cd_tekton_pipeline_definition", "cd_tekton_pipeline_definition_instance"]
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

is_valid(url) if {
	startswith(url, "^git$")
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
    attribute := block.Attributes
    is_valid(attribute.type)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Source type is git",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Source type is not git",
		"snippet": block,
	}
}