# METADATA
# title: "Verify the existence and integrity of API Keys and Project ID"
# description: "This policy ensures that API keys and project IDs are not only present but also complete, safeguarding against potential security breaches and ensuring smooth functioning of systems reliant on these identifiers."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_catalog
# custom:
#   id: CB_TFIBM_003
#   severity: HIGH
package lib.terraform.CB_TFIBM_003

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cm_catalog", "cm_catalog"]
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
	isvalid(resource)
	some block in resource.Blocks
	attribute := block.Attributes
	"api_key" in object.keys(attribute)
	"project_id" in object.keys(attribute)
	api := attribute.api_key
	project := attribute.project_id
	is_string(api)
	is_string(project)
	api != ""
	project != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "The API key and project ID exist and not null",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "The API key and project ID should be exist and not null",
		"snippet": block,
	}
}