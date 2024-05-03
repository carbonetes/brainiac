# METADATA
# title: "Verify URLs for toolchain tool artifactory is secured"
# description: "This policy ensures that URLs associated with the toolchain tool artifactory are secured with HTTPS protocol. Secure communication protocols are essential for protecting sensitive data and maintaining the integrity of the deployment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cd_toolchain_tool_artifactory
# custom:
#   id: CB_TFIBM_112
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_112

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

is_valid(url) if {
	startswith(url, "https://")
}

fail contains resource if {
	some resource in input
	isvalid(resource)
    some block in resource.Blocks
	attribute := block.Attributes
	not is_valid(attribute.dashboard_url)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
    some block in resource.Blocks
	attribute := block.Attributes
    not is_valid(attribute.mirror_url)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
    some block in resource.Blocks
	attribute := block.Attributes
    not is_valid(attribute.release_url)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
    some block in resource.Blocks
	attribute := block.Attributes
    not is_valid(attribute.repository_url)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
    some block in resource.Blocks
	attribute := block.Attributes
    not is_valid(attribute.snapshot_url)
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Toolchain URLs is secured",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Toolchain URLs is not secured",
		"snippet": block,
	}
}