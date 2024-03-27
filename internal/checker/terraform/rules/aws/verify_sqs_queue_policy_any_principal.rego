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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels
    supported_resources := ["aws_sqs_queue_policy", "aws_sqs_queue"]
    label in supported_resources
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

fail contains resource if {
	some resource in input
    isvalid(resource)
    access_policy := json.unmarshal(resource.Attributes.policy).Statement[_]
    access_policy.Principal == "*"
    access_policy.Effect == "Allow"
}

pass contains block if {
    some block in input
	isvalid(block)
   	not fail[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_sqs_queue_policy' or 'aws_sqs_queue' for 'policy' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_sqs_queue_policy' or 'aws_sqs_queue' for 'policy' should be set.",
                "snippet": block }
} 