# METADATA
# title: "Verify referenced component is defined"
# description: " This policy is designed to ensure that resources are accurately classified by type, enabling clear identification and streamlined management within the environment. "
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/code_engine_binding
# custom:
#   id: CB_TFIBM_108
#   severity: LOW
package lib.terraform.CB_TFIBM_108
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
    label == "ibm_code_engine_binding"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains block if {
    some block in input
    isvalid(block)
    not pass[block]
}

pass contains resource if {
	some resource in input
	isvalid(resource)
    some block in resource.Blocks
    block.Type == "component"
    attributes := block.Attributes
    "resource_type" in object.keys(attributes)
    resource_type := attributes.resource_type
    pattern := "^.+$"
    regex.match(pattern, resource_type)
    count(resource_type) <= 63
    resource_type != ""
}

passed contains result if {
	some block in pass
	result := {
		"message": "Resource type is properly set.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Resource type is properly set.",
		"snippet": block,
	}
}
