# METADATA
# title: "Verify Required Attributes in Rancher Catalog Configuration"
# description: "This policy ensures that Rancher Catalog configuration includes the required attributes for proper functionality."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/catalog
# custom:
#   id: CB_TFRAN_038
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_038

import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_catalog" in block.Labels
}

pass[block] {
    some block in input
    isvalid(block)
    block.Attributes.name != ""
    block.Attributes.url != ""
    block.Attributes.branch != ""
}

fail[block] {
    some block in input
    isvalid(block)
    not pass[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Catalog configuration includes all required attributes.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Catalog configuration is missing one or more required attributes. Check and fix the configuration.",
        "snippet": block,
    }
}
