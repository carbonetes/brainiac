# METADATA
# title: "Verify that Spanner Databases use Customer Supplied Encryption Keys (CSEK)"
# description: "This check ensures that Google Cloud Spanner databases are configured to use Customer Supplied Encryption Keys (CSEK) for encryption. CSEK allows customers to have greater control over the encryption keys used to protect their data in Spanner, providing an additional layer of security."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/spanner_database
# custom:
#   id: CB_TFGCP_097
#   severity: LOW
package lib.terraform.CB_TFGCP_097

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_spanner_database" in block.Labels
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
	some block in resource.Blocks
	block.Type == "encryption_spec"
	block.Attributes.kms_key_name != ""
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Google Cloud Spanner Database is configured to use Customer Supplied Encryption Keys (CSEK), enhancing data security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Google Cloud Spanner Database is not configured to use Customer Supplied Encryption Keys (CSEK), posing a potential security risk to data.",
		"snippet": block,
	}
}
