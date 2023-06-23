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


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_dynamodb_global_table"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)   
}

passed[result] {
	block := pass[_]
	result := { "message": "Global tables have Dynamodb point in time recovery (backup) enabled.",
                "snippet": block }
}

failed := []