# METADATA
# title: "Verify type for toolchain tool artifactory is configured"
# description: "This policy ensures that the type attribute of the specified resource blocks is limited to a predefined set of values. By restricting the allowed types to a predefined list, this policy helps maintain consistency and control over the resources within the deployment environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cd_toolchain_tool_artifactory
# custom:
#   id: CB_TFIBM_113
#   severity: LOW
package lib.terraform.CB_TFIBM_113

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cd_toolchain_tool_artifactory", "cd_toolchain_tool_artifactory_instance"]
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
    some block in resource.Blocks
	attribute := block.Attributes
	value := ["npm", "maven", "docker"]
    attribute.type in value
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Type is properly configured",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Type is not properly configured",
		"snippet": block,
	}
}