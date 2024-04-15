# METADATA
# title: "Verify supported cluster region is set"
# description: "This policy verifies that the chosen cluster region for IBM Cloud offering instances is supported, ensuring compatibility and preventing deployment errors. Compliance ensures smooth operations within the supported cluster regions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_offering_instance
# custom:
#   id: CB_TFIBM_024
#   severity: LOW
package lib.terraform.CB_TFIBM_024

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cm_offering_instance", "cm_offering_instance"]
	label in supported_resource
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
	attribute := resource.Attributes	
    value := ["us-south", "us-east", "br-sao", "ca-tor", "eu-gb", "eu-es", "eu-de", "jp-osa", "jp-tok", "au-syd"]
    attribute.cluster_region in value
}


fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Region is supported",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Region is not supported",
		"snippet": block,
	}
}