# METADATA
# title: "Validate Rancher Certificate Names Follow Naming Conventions"
# description: "This policy ensures that Rancher Certificates follow a consistent naming convention for better organization and management."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/certificate
# custom:
#   id: CB_TFRAN_047
#   severity: LOW
package lib.terraform.CB_TFRAN_047

import future.keywords.in

is_valid(block) {
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
    is_valid(block)
    not startswith(block.Attributes.name, "cert-")  
}

pass[block] {
    some block in input
    is_valid(block)
    not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Certificate names follow the naming convention.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Certificate names should start with 'cert-' for naming convention adherence.",
        "snippet": block,
    }
}
