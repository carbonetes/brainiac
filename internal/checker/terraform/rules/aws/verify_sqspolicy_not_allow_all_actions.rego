# METADATA
# title: "Verify SQS policy does not allow ALL (*) actions."
# description: "By explicitly defining the allowed actions in the policy, the risk of unauthorized access and unintended operations on SQS queues is minimized."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy
# custom:
#   id: CB_TFAWS_079
#   severity: HIGH
package lib.terraform.CB_TFAWS_079

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_sqs_queue_policy"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 


allowAllAction(statement){
   statement.Action[_] == "*"
}

allowAllAction(statement){
    statement.Action == "*"
}

fail[block] {
    block := input[_]
    isvalid(block)
    policyStr := block.Attributes.policy
    policyParsed := json.unmarshal(policyStr)
    statement := policyParsed.Statement[0]
    statement.Effect == "Allow"
    allowAllAction(statement)
}

pass[block] {
    block := input[_]
	isvalid(block)
    not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "SQS policy does not allow ALL (*) actions.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "SQS policy should not allow ALL (*) actions.",
                "snippet": block}
}
