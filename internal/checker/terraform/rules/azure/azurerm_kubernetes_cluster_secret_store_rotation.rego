# METADATA
# title: "Enable automatic rotation of Secrets Store CSI Driver secrets for AKS clusters"
# description: "Ensure that Secrets Store CSI Driver secrets for AKS clusters are configured to automatically rotate to enhance security and manage access effectively"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_142
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_142

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_kubernetes_cluster" in block.Labels
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
    some innerblock in resource.Blocks
    innerblock.Type == "key_vault_secrets_provider"
	innerblock.Attributes.secret_rotation_enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}


passed[result] {
    some block in pass
    result := {
		"message": "Secrets Store CSI Driver secrets for AKS clusters are set to autorotate.",
		"snippet": block,
	}
}

failed[result] {
    some block in fail
    result := {
		"message": "Secrets Store CSI Driver secrets for AKS clusters must be set to autorotate.",
		"snippet": block,
	}
}