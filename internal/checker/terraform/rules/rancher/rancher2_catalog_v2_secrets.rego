# METADATA
# title: "Validate Secret Name and Namespace in Rancher Catalog V2 Configuration"
# description: "This policy ensures that if Secret Name is specified, Secret Namespace must also be provided in Rancher Catalog V2 configuration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/catalog_v2
# custom:
#   id: CB_TFRAN_043
#   severity: LOW
package lib.terraform.CB_TFRAN_043

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

fail[block] {
    some block in input
    isvalid(block)
    block.Attributes.secret_name != "" 
    block.Attributes.secret_namespace == ""  
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Catalog V2 configuration includes Secret Name and its corresponding Secret Namespace.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Catalog V2 configuration specifies Secret Name but does not provide Secret Namespace. Provide the Secret Namespace for proper configuration.",
        "snippet": block,
    }
}
