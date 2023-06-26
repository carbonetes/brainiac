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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_sns_topic_policy"
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

    policy := json.unmarshal(resource.Attributes.policy).Statement[_]
    policy.Principal == "*"
    policy.Effect == "Allow"
}


passed[result] {
	block := pass[_]
	result := { "message": "'aws_sns_topic_policy' for 'policy' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_sns_topic_policy' for 'policy' should be set.",
                "snippet": block }
} 