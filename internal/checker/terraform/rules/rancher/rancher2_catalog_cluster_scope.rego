# METADATA
# title: "Verify Rancher Catalog Configuration for Cluster Scope"
# description: "This policy ensures that the Rancher Catalog configuration has required attributes properly set when the scope is set to 'cluster' in a Terraform environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/catalog
# custom:
#   id: CB_TFRAN_037
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_037

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_catalog" in block.Labels
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
	block.Attributes.scope == "cluster"
	not "cluster_id" in object.keys(block.Attributes)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Catalog configuration is properly set for the cluster scope.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Catalog configuration has invalid or missing attributes for the cluster scope. Check and fix the configuration.",
        "snippet": block,
    }
}