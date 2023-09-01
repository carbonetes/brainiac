# METADATA
# title: "Verify that CloudFormation stacks are sending event notifications to an SNS topic"
# description: " It ensures that you receive real-time updates about stack events, automate actions based on those events, gain a centralized view of stack activities, and easily integrate with other AWS services."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudformation_stack.html
# custom:
#   id: CB_TFAWS_120
#   severity: LOW
package lib.terraform.CB_TFAWS_120

import future.keywords.in 


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudformation_stack"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

has_attribute(key, value) {
  _ = key[value]
}

pass[resource] {
    resource := input[_]
    isvalid(resource)
    has_attribute(resource.Attributes, "notification_arns")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_cloudformation_stack' are sending event notifications to an SNS topic",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_cloudformation_stack' 'notification_arns' should be set",
                "snippet": block}
}
