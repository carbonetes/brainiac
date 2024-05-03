# METADATA
# title: "Verify prefix is properly configured"
# description: "This policy is implemented to maintain a structured approach to resource naming through the use of prefixes, aiding in better organization and management of resources across the platform."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/code_engine_binding
# custom:
#   id: CB_TFIBM_104
#   severity: HIGH
package lib.terraform.CB_TFIBM_104
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
    pattern := "^[A-Z]([_A-Z0-9]*[A-Z0-9])*$"
    block := resource.Attributes
    "prefix" in object.keys(block)
    prefix := block.prefix
    regex.match(pattern, prefix)
    count(prefix) <= 31    
}

passed contains result if {
	some block in pass
	result := {
		"message": "Configured prefix properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Must configure prefix properly.",
		"snippet": block,
	}
}
