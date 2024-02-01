# METADATA
# title: "Verify Rancher Catalog V2 Configuration"
# description: "This policy ensures that Rancher Catalog V2 configuration includes the required attributes for proper functionality."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/catalog_v2
# custom:
#   id: CB_TFRAN_041
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_041

import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_catalog_v2" in block.Labels
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
        "message": "Rancher Catalog V2 configuration includes all required attributes.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Catalog V2 configuration is missing one or more required attributes. Check and fix the configuration.",
        "snippet": block,
    }
}
