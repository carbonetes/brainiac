# METADATA
# title: "Validate Rancher Catalog Version Attribute"
# description: "This policy ensures that the Rancher Catalog configuration has a valid version attribute."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/catalog
# custom:
#   id: CB_TFRAN_039
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_039

import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_catalog" in block.Labels
}

fail[block] {
    some block in input
    isvalid(block)
    not block.Attributes.version in ["helm_v2", "helm_v3"]
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Catalog configuration has set a valid version attribute or not exist.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Version attribute exists. Rancher Catalog configuration is missing the version attribute or has an invalid value. Check and fix the configuration.",
        "snippet": block,
    }
}
