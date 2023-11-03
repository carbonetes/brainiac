# METADATA
# title: "Enable point_in_time_recovery for DynamoDB tables"
# description: "This checks whether point_in_time_recovery is enabled for DynamoDB tables."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
# custom:
#   id: CB_TFAWS_016
#   severity: HIGH
package lib.terraform.CB_TFAWS_016

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_dynamodb_table"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
    block := fail[_]
	resource := concat(".", block.Labels)
}

pass[resource]{
    some index
    resource := input[_]
	isvalid(resource)
    resource.Blocks[index].Type == "point_in_time_recovery"
    resource.Blocks[index].Attributes.enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_dynamodb_table' 'point_in_time_recovery' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_dynamodb_table' 'point_in_time_recovery' must be set to true.",
                "snippet": block }
}