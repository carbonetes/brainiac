# METADATA
# title: "Validate Rancher Catalog Scope Attribute"
# description: "This policy ensures that the Rancher Catalog configuration has a valid scope attribute."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/catalog
# custom:
#   id: CB_TFRAN_040
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_040

import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_catalog" in block.Labels
}

fail[block] {
    some block in input
    isvalid(block)
    not block.Attributes.scope in ["cluster", "global", "project"]
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Catalog configuration has a valid scope attribute.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Catalog configuration is missing the scope attribute or has an invalid value. Check and fix the configuration.",
        "snippet": block,
    }
}
