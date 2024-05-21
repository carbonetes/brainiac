# METADATA
# title: "Verify secret name is set"
# description: "This policy ensures that the secret name conforms precisely to the prescribed constraints, encompassing character limits and pattern specifications, thereby mitigating the risk of naming discrepancies and facilitating seamless integration with the IBM Code Engine platform, warranting medium-level attention to maintain consistency and operational efficiency."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/code_engine_secret
# custom:
#   id: CB_TFIBM_082
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_082
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
    label == "ibm_code_engine_secret"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
    block := resource.Attributes
    "name" in object.keys(block)
    pattern := `^[a-z0-9]([\-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([\-a-z0-9]*[a-z0-9])?)*$`
    name := block.name
    regex.match(pattern, name)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
    block := resource.Attributes
	block.name != ""
	count(block.name) > 253
}

fail contains block if {
    some block in input
    isvalid(block)
    not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Secret name is set.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Secret name is not set.",
		"snippet": block,
	}
}
