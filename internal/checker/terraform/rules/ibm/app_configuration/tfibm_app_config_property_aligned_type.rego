# METADATA
# title: "Verify the property type is aligned with value"
# description: "This policy validates that the 'type' attribute aligns with the 'value' attribute in the 'ibm_app_config_property' resource. Misalignment can lead to operational issues."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/app_config_feature
# custom:
#   id: CB_TFIBM_038
#   severity: LOW
package lib.terraform.CB_TFIBM_038

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	"ibm_app_config_property" in block.Labels
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
	not fail[resource]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	hasMisalignedPropertyType(resource)
}

hasMisalignedPropertyType(block) if {
	block.Attributes.type == "BOOLEAN"
	not regex.match(`^(true|false)$`, block.Attributes.value)
} else if {
	block.Attributes.type == "STRING"
	not is_string(block.Attributes.value)
} else if {
	block.Attributes.type == "NUMERIC"
	not is_number(block.Attributes.value)
}

passed contains result if {
	some block in pass
	result := {
		"message": "IBM App Config Property resource property type in value is aligned, preventing operational issues.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IBM App Config Property resource has a misaligned property type in value, which could lead to operational issues.",
		"snippet": block,
	}
}
