# METADATA
# title: "Validate Exclusive Git Repository or URL for Rancher Catalog V2 Configuration"
# description: "This policy ensures that only either Git Repository or URL is specified, not both, in Rancher Catalog V2 configuration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/catalog_v2
# custom:
#   id: CB_TFRAN_042
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_042

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
    not "url" in object.keys(block.Attributes)
    "git_repo" in object.keys(block.Attributes)
}

pass[block] {
    some block in input
    isvalid(block)
    "url" in object.keys(block.Attributes)
    not "git_repo" in object.keys(block.Attributes)
}

fail[block] {
    some block in input
    isvalid(block)
    not pass[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Catalog V2 configuration specifies either Git Repository or URL exclusively.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Catalog V2 configuration should specify either Git Repository or URL exclusively, not both.",
        "snippet": block,
    }
}