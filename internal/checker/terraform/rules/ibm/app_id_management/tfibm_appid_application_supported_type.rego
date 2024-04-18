# METADATA
# title: "Verify the supported application type"
# description: "This policy validates that the 'type' attribute of the 'ibm_appid_application' resource is either 'singlepageapp' or 'regularwebapp'. Misalignment can lead to operational issues."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/appid_application
# custom:
#   id: CB_TFIBM_029
#   severity: LOW
package lib.terraform.CB_TFIBM_029

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	"ibm_appid_application" in block.Labels
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
	hasInvalidApplicationType(resource)
}

hasInvalidApplicationType(block) if {
	block.Attributes.type != "singlepageapp"
	block.Attributes.type != "regularwebapp"
}

passed contains result if {
	some block in pass
	result := {
		"message": "IBM AppID Application resource has a valid application type.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IBM AppID Application resource has an invalid application type.",
		"snippet": block,
	}
}
