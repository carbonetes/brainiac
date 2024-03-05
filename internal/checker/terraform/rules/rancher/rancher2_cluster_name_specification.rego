# METADATA
# title: "Verify Cluster Name in Rancher2 Clusters"
# description: "Policy to ensure that the 'name' attribute is provided for Rancher2 Clusters."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster
# custom:
#   id: CB_TFRAN_058
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_058
import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_cluster" in block.Labels
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
		"message": "Cluster names are provided and not empty.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Cluster name cannot be empty. Please provide a valid name.",
		"snippet": block,
	}
}

