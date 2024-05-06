# METADATA
# title: "Make certain that global tables have Dynamodb point in time recovery (backup) enabled"
# description: "For Amazon DynamoDB global tables, turning on point-in-time recovery (PITR) can assist prevent data loss due to unintentional write or delete operations, data corruption, or both. "
# scope: package
# related_resources:
# - https://aws.amazon.com/dynamodb/global-tables/
# custom:
#   id: CB_TFAWS_156
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_156
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	"aws_dynamodb_global_table" in block.Labels
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
} 

pass contains resource if {
	some resource in input
	isvalid(resource)   
}

passed contains result if {
	some block in pass
	result := { "message": "Global tables have Dynamodb point in time recovery (backup) enabled.",
                "snippet": block }
}

failed := []