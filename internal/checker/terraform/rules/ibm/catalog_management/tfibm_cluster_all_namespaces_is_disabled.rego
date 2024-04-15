# METADATA
# title: "Verify cluster all namespaces is disabled"
# description: "This policy helps maintain a more controlled deployment environment, reducing the risk of unintended namespace interference and ensuring adherence to namespace-specific configurations."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_offering_instance
# custom:
#   id: CB_TFIBM_025
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_025

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
    attribute.cluster_all_namespaces == false
}


fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Cluster all namespaces is disabled",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Cluster all namespaces should be disabled",
		"snippet": block,
	}
}