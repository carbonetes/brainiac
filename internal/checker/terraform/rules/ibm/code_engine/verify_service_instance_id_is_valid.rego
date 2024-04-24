# METADATA
# title: "Verify Service instance and Resource key ID is valid"
# description: "This policy ensures the format of the service instance ID and resource key ID adheres to the specified constraints, including length limitations and character requirements, to prevent potential misconfiguration and ensure compatibility with the IBM Code Engine platform."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/code_engine_secret
# custom:
#   id: CB_TFIBM_073
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_073
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

fail contains block if {
    some block in input
    isvalid(block)
    some path in block.Blocks
    some res in path.Blocks
    attributes := res.Attributes
    "id" in object.keys(attributes)
    pattern := `^[a-z0-9][\-a-z0-9]*[a-z0-9]$`
    not regex.match(pattern, attributes["id"])
}

fail contains block if {
    some block in input
    isvalid(block)
    some path in block.Blocks
    some res in path.Blocks
    res.Type == "service_instance"
    id := res.Attributes.id
    count(id) != 36
}

fail contains block if {
    some block in input
    isvalid(block)
    some path in block.Blocks
    some res in path.Blocks
    res.Type == "resource_key"
    id := res.Attributes.id
    count(id) > 36
}

pass contains resource if {
	some resource in input
	isvalid(resource)
    not fail[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Service Instance and Resource key ID is valid.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Service Instance and Resource key ID is not valid.",
		"snippet": block,
	}
}
