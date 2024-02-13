# METADATA
# title: "Verify Rancher2 Cluster Role Template Binding Configuration"
# description: "Policy ensuring validation of Rancher2 Cluster Role Template Binding configuration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_role_template_binding
# custom:
#   id: CB_TFRAN_073
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_073

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_cluster_role_template_binding" in block.Labels
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
	block.Attributes.cluster_id != ""
	block.Attributes.role_template_id != ""
    block.Attributes.name != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Cluster Role Template Binding configuration successfully verified for compliance with policy requirements.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure to meet Rancher2 Cluster Role Template Binding configuration requirements. Review and adjust configuration to ensure compliance with the policy.",
		"snippet": block,
	}
}
