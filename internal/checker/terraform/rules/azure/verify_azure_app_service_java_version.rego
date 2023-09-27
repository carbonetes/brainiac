# METADATA
# title: "Verify that 'Java version' is the latest, if used to run the web app"
# description: "This policy is designed to enhance the security and performance of web applications by verifying that the latest version of Java is used, if Java is the runtime for the web app."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_074
#   severity: LOW
package lib.terraform.CB_TFAZR_074

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
	innerBlock.Attributes.java_version == "11"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The web app is using the latest version of Java (11).",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The web app is not using the latest version of Java (11).",
		"snippet": block,
	}
}