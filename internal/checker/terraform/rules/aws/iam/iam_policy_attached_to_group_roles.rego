# METADATA
# title: "Verify that  IAM policies are attached only to groups, roles to avoid privilege escalation"
# description: "IAM policies are attached only to groups, roles to avoid privilege escalation"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy
# custom:
#   id: CB_TFAWS_047
#   severity: LOW
package lib.terraform.CB_TFAWS_047

supportedResources := ["aws_iam_user_policy_attachment", "aws_iam_user_policy", "aws_iam_policy_attachment"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(input[_].Attributes, "user")
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_iam_user_policy_attachment', 'aws_iam_user_policy', 'aws_iam_policy_attachment' 'user' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_iam_user_policy_attachment', 'aws_iam_user_policy', 'aws_iam_policy_attachment' 'user' is not set properly.",
                "snippet": block }
} 