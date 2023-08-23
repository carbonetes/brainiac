# METADATA
# title: "Verify AWS Managed IAMFullAccess IAM policy is not used"
# description: "By preventing the use of the IAMFullAccess policy, the organization can better control and restrict the permissions granted to IAM principals, reducing the risk of unauthorized access and potential security breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy.html
# custom:
#   id: CB_TFAWS_354
#   severity: HIGH
package lib.terraform.CB_TFAWS_354

supportedResources := ["aws_iam_role", 
                       "aws_iam_group_policy_attachment", 
                       "aws_iam_policy_attachment", 
                       "aws_iam_role_policy_attachment", 
                       "aws_iam_user_policy_attachment", 
                       "aws_ssoadmin_managed_policy_attachment"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
}

isvalid(block){
	block.Type == "data"
    block.Labels[_] == "aws_iam_policy"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource] {
    resource := input[_]
    isvalid(resource)
    resource.Attributes.name == "IAMFullAccess"
}

fail[resource] {
    resource := input[_]
    isvalid(resource)
    contains(resource.Attributes.arn, "IAMFullAccess")
}

fail[resource] {
    resource := input[_]
    isvalid(resource)
    contains(resource.Attributes.policy_arn, "IAMFullAccess")
}

fail[resource] {
    resource := input[_]
    isvalid(resource)
    contains(resource.Attributes.managed_policy_arn, "IAMFullAccess")
}

fail[resource] {
    resource := input[_]
    isvalid(resource)
    arnPolicies := resource.Attributes.managed_policy_arn[_]
    contains(arnPolicies, "IAMFullAccess")
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "AWS Managed IAMFullAccess IAM policy is not used.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "AWS Managed IAMFullAccess IAM policy should not be used.",
                "snippet": block }
} 