# METADATA
# title: "Verify that 'Net Framework' version is the latest, if used as a part of the web app"
# description: "This policy is designed to enhance the security and performance of web applications by verifying that the latest version of the .NET Framework is used, if applicable."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_052
#   severity: LOW
package lib.terraform.CB_TFAZR_052

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_app_service" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
	some block in input
	isvalid(block)
	some innerBlock in block.Blocks
	innerBlock.Type == "site_config"
	innerBlock.Attributes.dotnet_framework_version == "v6.0"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The web app is using the latest .NET Framework version (v6.0).",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The web app is not using the latest .NET Framework version (v6.0).",
		"snippet": block,
	}
}