# METADATA
# title: "Verify that encryption is enabled for Data Lake Store accounts"
# description: "Check and ensure that Data Lake Store accounts have encryption enabled. This security measure helps protect data by encrypting it, making it more secure against unauthorized access"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/Devolutions/azurerm/latest/docs/resources/data_lake_store
# custom:
#   id: CB_TFAZR_103
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_103

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_data_lake_store" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.encryption_state == "Enabled"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "Encryption is verified to be enabled for Data Lake Store accounts.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Encryption is not enabled for Data Lake Store accounts as required.",
		"snippet": block,
    }
}
