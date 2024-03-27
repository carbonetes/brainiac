# METADATA
# title: "Verify that SNS topic policy is not public by only allowing specific services or principals to access it"
# description: "By restricting access to the SNS topic and allowing only specific services or principals, it helps enhance security by minimizing the potential attack surface and ensuring that only authorized entities can publish messages to the topic."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/2.62.0/docs/resources/sns_topic_policy
# custom:
#   id: CB_TFAWS_160
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_160
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_sns_topic_policy"
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

    policy := json.unmarshal(resource.Attributes.policy).Statement[_]
    policy.Principal == "*"
    policy.Effect == "Allow"
}

pass contains block if {
	some block in input
	isvalid(block)
   	not fail[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_sns_topic_policy' for 'policy' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_sns_topic_policy' for 'policy' should be set.",
                "snippet": block }
} 