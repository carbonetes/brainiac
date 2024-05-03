# METADATA
# title: "Verify value for pipeline property is secured"
# description: "This policy pipeline property to use HTTPS for secure communication and mandates validation of resource attributes to prevent security vulnerabilities like injection attacks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cd_tekton_pipeline_property
# custom:
#   id: CB_TFIBM_111
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_111

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cd_tekton_pipeline_property", "cd_tekton_pipeline_property_instance"]
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

fail contains resource if {
	some resource in input
	isvalid(resource)
    attribute := resource.Attributes
    not is_valid(attribute.value)
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Pipeline property value is secured",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Pipeline property value is not secured",
		"snippet": block,
	}
}