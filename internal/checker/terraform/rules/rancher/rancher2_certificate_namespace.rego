# METADATA
# title: "Validate Rancher Certificate Namespace Configuration"
# description: "This policy ensures that the Rancher Certificate configuration has a valid namespace_id when creating a namespaced certificate."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/certificate
# custom:
#   id: CB_TFRAN_045
#   severity: LOW
package lib.terraform.CB_TFRAN_045

import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_certificate" in block.Labels
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
    block.Attributes.namespace_id != ""  
    not "project_id" in object.keys(block.Attributes)  
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Certificate namespace configuration is valid.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Certificate configuration has an invalid or missing namespace_id when creating a namespaced certificate. Check and fix the configuration.",
        "snippet": block,
    }
}