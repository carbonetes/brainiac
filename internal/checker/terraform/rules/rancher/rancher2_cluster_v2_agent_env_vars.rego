# METADATA
# title: "Verify Rancher2 Cluster V2 Agent Environment Variables"
# description: Policy to verify that Rancher2 Cluster V2 Configuration includes Agent Environment Variables and is properly set up."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_v2
# custom:
#   id: CB_TFRAN_188
#   severity: LOW
package lib.terraform.CB_TFRAN_188

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_cluster_v2" in block.Labels
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
	some innerblock in block.Blocks
	innerblock.Type == "agent_env_vars"
	innerblock.Attributes.name == ""
}

fail[block] {
	some block in input
	isvalid(block)
	some innerblock in block.Blocks
	innerblock.Type == "agent_env_vars"
	innerblock.Attributes.value == ""
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Cluster V2 Configuration successfully validated with the inclusion and proper setup of Agent Environment Variables.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Cluster V2 Configuration. Ensure that Agent Environment Variables are included and set up properly.",
		"snippet": block,
	}
}
