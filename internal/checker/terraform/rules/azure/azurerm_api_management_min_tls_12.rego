# METADATA
# title: "Require API management to utilize TLS 1.2 as a minimum security protocol version"
# description: "Make sure that API management enforces the use of TLS 1.2 as the minimum security protocol version to enhance security and protect data during communication"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management
# custom:
#   id: CB_TFAZR_143
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_143

import future.keywords.in
import future.keywords.if

isvalid(block) {
	block.Type == "resource"
	"azurerm_api_management" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some innerblock in resource.Blocks
	innerblock.Type == "security"
    hasInvalidAttribute(innerblock)
}

hasInvalidAttribute(block) := true if {
  block.Attributes.enable_backend_tls1
} else := true if {
    block.Attributes.enable_frontend_ssl3
} else := true if {
    block.Attributes.enable_frontend_tls10
} else := true if {
    block.Attributes.enable_frontend_tls11
} else := true if {
    block.Attributes.enable_backend_tls1
} else := true if {
    block.Attributes.enable_back_end_ssl30
}

passed[result] {
	some block in pass
	result := {
		"message": "Require API management to utilize TLS 1.2 as a minimum security protocol version.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Require API management to utilize TLS 1.2 as a minimum security protocol version.",
		"snippet": block,
	}
}
