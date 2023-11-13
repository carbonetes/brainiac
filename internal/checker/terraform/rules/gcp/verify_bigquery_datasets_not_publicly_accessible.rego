# METADATA
# title: "Verify that BigQuery datasets are not anonymously or publicly accessible"
# description: "By restricting access, it safeguards sensitive data and prevents unauthorized users from querying or viewing datasets in BigQuery, maintaining data privacy and security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset
# custom:
#   id: CB_TFGCP_034
#   severity: HIGH
package lib.terraform.CB_TFGCP_034
import future.keywords.in

import future.keywords.if

isvalid(block){
	block.Type == "resource"
    "google_bigquery_dataset" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[block] {
    some block in input
	isvalid(block)
   	some inner_block in block.Blocks
	inner_block.Type == "access"
	invalid_groups := ["allAuthenticatedUsers", "allUsers"]
	inner_block.Attributes.special_group in invalid_groups
}

fail[block] {
    some block in input
	isvalid(block)
   	some inner_block in block.Blocks
	inner_block.Type == "access"
	not has_object_key(inner_block)
}

has_object_key(inner_block) := true if{
	"user_by_email" in object.keys(inner_block.Attributes)
} else := true if {
	"group_by_email" in object.keys(inner_block.Attributes)
} else := true if {
	"domain" in object.keys(inner_block.Attributes)
} else := true if {
	"view" in object.keys(inner_block.Attributes)
} else := true if {
	"routine" in object.keys(inner_block.Attributes)
} else := true if {
	"dataset" in object.keys(inner_block.Attributes)
} 

pass[block] {
    some block in input
	isvalid(block)
    not fail[block]
}


passed[result] {
    some block in pass
	result := { "message": "BigQuery datasets are not anonymously or publicly accessible.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "BigQuery datasets should not anonymously or publicly accessible.",
                "snippet": block }
}