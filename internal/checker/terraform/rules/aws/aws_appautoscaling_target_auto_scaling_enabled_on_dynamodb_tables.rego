# METADATA
# title: "Check to see if Auto Scaling is activated for your DynamoDB tables"
# description: "Determines if DynamoDB tables are configured for autoscaling. Keep in mind that such setup is automatically included for tables with billing_mode = PAY_PER_REQUEST."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
# custom:
#   id: CB_TFAWS_350
#   severity: LOW
package lib.terraform.CB_TFAWS_350

import future.keywords.if

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

getTheLabelForAwsDynamodbTable[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_dynamodb_table"
    expectedResources := ["PROVISIONED", "PAY_PER_REQUEST"]
    resource.Attributes.billing_mode == expectedResources[_]
    label := concat(".", resource.Labels)
}

getTheLabelForAwsDynamodbTableNoBillingMode[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_dynamodb_table"
    label := concat(".", resource.Labels)
}

verifyBillingModeForAwsDynamodbTable{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_dynamodb_table"
    resource.Attributes.billing_mode
}

verifyAwsDynamodbTable{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_dynamodb_table"
    resource.Attributes.billing_mode == "PAY_PER_REQUEST"
}

isAwsAppAutoscalingTargetAttachedForDynamodb{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_appautoscaling_target"
    contains(resource.Attributes.resource_id, getTheLabelForAwsDynamodbTable[_])
}

isAwsAppAutoscalingTargetAttachedForDynamodbNoBillingMode{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_appautoscaling_target"
    contains(resource.Attributes.resource_id, getTheLabelForAwsDynamodbTableNoBillingMode[_])
}

isValidAttachments := true if{
    not verifyBillingModeForAwsDynamodbTable
    isAwsAppAutoscalingTargetAttachedForDynamodbNoBillingMode
}else := true if {
    isAwsAppAutoscalingTargetAttachedForDynamodb
}else := true if {
    verifyAwsDynamodbTable
}
 
pass[resource]{
    resource := input[_]
    isvalid(resource)
    isValidAttachments
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The Auto Scaling is activated for your DynamoDB tables.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The Auto Scaling must be activated for your DynamoDB tables.",
                "snippet": block }
} 