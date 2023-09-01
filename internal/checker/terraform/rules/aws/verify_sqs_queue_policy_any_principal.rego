# METADATA
# title: "Verify that SQS queue policy is not public by only allowing specific services or principals to access it"
# description: "By restricting access to an SQS queue through a specific policy, only allowing designated services or principals, you ensure the security and integrity of your queue, preventing unauthorized access and potential misuse."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy
# custom:
#   id: CB_TFAWS_159
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_159

supportedResources := ["aws_sqs_queue_policy", "aws_sqs_queue"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

fail[resource] {
	resource := input[_]
    isvalid(resource)

    access_policy := json.unmarshal(resource.Attributes.policy).Statement[_]
    access_policy.Principal == "*"
    access_policy.Effect == "Allow"
}


passed[result] {
	block := pass[_]
	result := { "message": "'aws_sqs_queue_policy' or 'aws_sqs_queue' for 'policy' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_sqs_queue_policy' or 'aws_sqs_queue' for 'policy' should be set.",
                "snippet": block }
} 