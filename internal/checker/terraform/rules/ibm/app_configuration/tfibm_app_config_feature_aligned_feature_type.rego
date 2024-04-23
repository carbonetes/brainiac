# METADATA
# title: "Verify the feature type is aligned with enabled and disabled values"
# description: "This policy validates that the 'type' attribute aligns with the 'enabled_value' and 'disabled_value' attributes in the 'ibm_app_config_feature' resource. Misalignment can lead to operational issues."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/app_config_feature
# custom:
#   id: CB_TFIBM_031
#   severity: LOW
package lib.terraform.CB_TFIBM_031

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	"ibm_app_config_feature" in block.Labels
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
	hasMisalignedFeatureType(resource)
}

hasMisalignedFeatureType(block) if {
	block.Attributes.type == "BOOLEAN"
	not regex.match(`^(true|false)$`, block.Attributes.enabled_value)
	not regex.match(`^(true|false)$`, block.Attributes.disabled_value)
} else if {
	block.Attributes.type == "STRING"
	not is_string(block.Attributes.enabled_value)
	not is_string(block.Attributes.disabled_value)
} else if {
	block.Attributes.type == "NUMERIC"
	not is_number(block.Attributes.enabled_value)
	not is_number(block.Attributes.disabled_value)
}

passed contains result if {
    some block in pass
    result := {
        "message": "IBM App Config Feauture resource feature types and enabled/disabled values are aligned, preventing operational issues.",
        "snippet": block,
    }
}

failed contains result if {
    some block in fail
    result := {
        "message": "IBM App Config Feauture resource has a misaligned feature type in enabled/disabled values, which could lead to operational issues.",
        "snippet": block,
    }
}
