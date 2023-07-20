# METADATA
# title: "Prohibit the usage of the AWS "AdministratorAccess" policy for IAM roles, users, and groups"
# description: "This policy aims to prevent IAM roles, users, and groups from employing the "AdministratorAccess" policy in AWS, which grants extensive permissions and should be carefully controlled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
# custom:
#   id: CB_TFAWS_250
#   severity: HIGH
package lib.terraform.CB_TFAWS_250

supportedResources := ["aws_iam_role", "aws_iam_group_policy_attachment", "aws_iam_policy_attachment", "aws_iam_role_policy_attachment", "aws_iam_user_policy_attachment", "aws_ssoadmin_managed_policy_attachment"]

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

fail[resource] {
    resource := input[_]
    isvalid(resource)
    managed_policy_arns := resource.Attributes.managed_policy_arns
    policy_arn := resource.Attributes.policy_arn
    ends_with_admin_access(managed_policy_arns)
}

ends_with_admin_access(arns) {
    arn := arns[_]
    regex.match(".+/AdministratorAccess$", arn)
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Utilizing AWS AdministratorAccess policy is denied for IAM roles, users, and groups.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Utilizing AWS AdministratorAccess policy must be denied for IAM roles, users, and groups.",
                "snippet": block }
} 