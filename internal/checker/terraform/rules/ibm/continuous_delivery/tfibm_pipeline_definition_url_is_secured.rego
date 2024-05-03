# METADATA
# title: "Verify pipeline definition url is secured"
# description: "This policy denies when the URL is hardcoded in the configuration, flagging it as a risk due to sensitive information exposure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cd_tekton_pipeline_definition
# custom:
#   id: CB_TFIBM_109
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_109

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
	startswith(url, "https://")
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	some blocks in block.Blocks
    attribute := blocks.Attributes
    is_valid(attribute.url)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "URL is secured",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "URL is not secured",
		"snippet": block,
	}
}