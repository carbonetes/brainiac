# METADATA
# title: "Verify referenced component is defined"
# description: "This policy is created to enforce standardized naming conventions for components, reducing the risk of ambiguity or errors during resource management and fostering consistency across deployments."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/code_engine_secret
# custom:
#   id: CB_TFIBM_107
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_107
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
    "name" in object.keys(attributes)
    name := attributes.name
    pattern := "^[a-z0-9]([\\-a-z0-9]*[a-z0-9])?$"
    regex.match(pattern, name)
    count(name) <= 63
    name != ""
}

passed contains result if {
	some block in pass
	result := {
		"message": "Referenced component is properly defined.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Referenced component is not defined.",
		"snippet": block,
	}
}
