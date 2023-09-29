# METADATA
# title: "Confirm that function apps are not reachable from all IP addresses"
# description: "Verify that function apps are not accessible from all IP addresses. This security measure confirms that the apps remain protected from unauthorized access via restricted IP domains."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app
# custom:
#   id: CB_TFAZR_092
#   severity: LOW
package lib.terraform.CB_TFAZR_092

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_function_app" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[block] {
	some block in input
	isvalid(block)
	some innerBlock in block.Blocks
    innerBlock.Type == "site_config"
	some innermostBlock in innerBlock.Blocks
	innermostBlock.Type == "cors"
	"*" in innermostBlock.Attributes.allowed_origins
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Function apps are not reachable from all IP addresses.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Function apps must not be reachable from all IP addresses.",
		"snippet": block,
	}
}