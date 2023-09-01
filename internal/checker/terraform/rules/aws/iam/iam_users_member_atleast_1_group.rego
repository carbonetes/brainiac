# METADATA
# title: "Verify that all IAM users are members of at least one IAM group."
# description: "This practice simplifies access control, enhances security, and makes permissions management more efficient by applying permissions to groups instead of individual users."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership.html
# custom:
#   id: CB_TFAWS_317
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_317

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_iam_group_membership"
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

isIAMUserExist{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_iam_user"
}

isIAMGroupExist{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_iam_group"
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    isIAMUserExist
    isIAMGroupExist
    has_attribute(resource.Attributes, "users")
    has_attribute(resource.Attributes, "group")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "All IAM users are members of at least one IAM group.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "All IAM users must be member of at least one IAM group.",
                "snippet": block }
} 