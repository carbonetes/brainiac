# METADATA
# title: "Verify that backup region is set"
# description: "This policy validates that the 'metadata_region_backup' attribute is configured for the 'ibm_atracker_settings' resource. A backup region is crucial for ensuring data availability. In case of a regional outage, a backup region allows for a seamless transition, minimizing potential downtime and data loss."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/atracker_settings
# custom:
#   id: CB_TFIBM_012
#   severity: LOW
package lib.terraform.CB_TFIBM_012

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	"ibm_atracker_settings" in block.Labels
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
	hasInvalidBackupRegion(resource)
}

hasInvalidBackupRegion(block) if {
	not regex.match(`^[a-zA-Z0-9 -_]{3,256}$`, block.Attributes.metadata_region_backup)
}

passed contains result if {
	some block in pass
	result := {
		"message": "IBM ATracker Settings have a backup region set, ensuring data availability.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IBM ATracker Settings must have a backup region set to ensure data availability.",
		"snippet": block,
	}
}
