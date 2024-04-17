# METADATA
# title: "Verify that Data Events are enabled"
# description: "This policy validates the activation of data events, ensuring that they are enabled to facilitate comprehensive monitoring and auditing of data-related activities within the Cloudant service, thereby enhancing visibility and compliance with data governance requirements."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cloudant
# custom:
#   id: CB_TFIBM_054
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_054
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "ibm_cloudant"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains block if {
    some block in input
    isvalid(block)
    not fail[block]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	res := resource.Attributes
    res.include_data_events == false
}

passed contains result if {
	some block in pass
	result := {
		"message": "Data events is enabled.",
		"snippet": block
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Data events must be enabled.",
		"snippet": block,
	}
}
