# METADATA
# title: "Verify that AKS utilizes disk encryption settings"
# description: "Confirm that AKS (Azure Kubernetes Service) employs disk encryption settings, enhancing data security and confidentiality by encrypting the disks used within the AKS environment"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_119
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_119

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
	resource.Attributes.disk_encryption_set_id != null
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "AKS is verified to utilize disk encryption settings.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "AKS does not utilize disk encryption settings as required.",
		"snippet": block,
    }
}