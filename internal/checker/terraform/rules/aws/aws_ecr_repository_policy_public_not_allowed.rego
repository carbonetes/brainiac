# METADATA
# title: "Make certain that the ECR policy is not set to public"
# description: "To help prevent data leaking, it is advised that you restrict public access to ECR repositories."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy
# custom:
#   id: CB_TFAWS_029
#   severity: INFO
package lib.terraform.CB_TFAWS_029

import future.keywords.in 

supportedResource := ["aws_ecr_repository_policy"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[block] {
    block := input[_]
    isvalid(block)
    policyStr := block.Attributes.policy
    policyParsed := json.unmarshal(policyStr)
    statement := policyParsed.Statement[0]
    statement.Effect == "Allow"
    principal := statement.Principal
    principal == "*"
}

pass[block] {
    block := input[_]
	isvalid(block)
    not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "ECS repositories are configured to disallow public access.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "ECS repositories should be configured to disallow public access.",
                "snippet": block}
}
