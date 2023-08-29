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

has_attribute(key, value) {
  _ = key[value]
}

getTheLabelForAwsDynamodbTable[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_dynamodb_table"
    resource.Attributes.billing_mode == "PROVISIONED"
    label := concat(".", resource.Labels)
}

getTheLabelForAwsDynamodbTable[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_dynamodb_table"
    not has_attribute(resource.Attributes, "billing_mode")
    label := concat(".", resource.Labels)
}

isAwsAppAutoscalingTargetAndPolicyAttachedForDynamodb{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_appautoscaling_target"
    contains(resource.Attributes.resource_id, getTheLabelForAwsDynamodbTable[_])
    policyIsAttached
}
getLabelForScalingTarget[label]{
	resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_appautoscaling_target"
    label := concat(".", resource.Labels)
}

policyIsAttached{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_appautoscaling_policy"
    contains(resource.Attributes.resource_id, getLabelForScalingTarget[_])
}
 
pass[resource]{
    resource := input[_]
    isvalid(resource)
    isAwsAppAutoscalingTargetAndPolicyAttachedForDynamodb
}

pass[resource]{
    resource := input[_]
    isvalid(resource)
    resource.Attributes.billing_mode == "PAY_PER_REQUEST"
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