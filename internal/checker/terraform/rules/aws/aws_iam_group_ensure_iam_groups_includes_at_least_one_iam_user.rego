# METADATA
# title: "A minimum of one IAM user must be present in IAM groups"
# description: "A minimum of one IAM user should be present in each IAM group. When you need to assign particular activities or obligations to other users, this could be beneficial to verify that at least one person has the privileges connected to the group."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group.html
# custom:
#   id: CB_TFAWS_347
#   severity: LOW
package lib.terraform.CB_TFAWS_347

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_iam_group"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getTheLabelforAwsIamGroup[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_iam_group"
    label := concat(".", resource.Labels)
}

getTheLabelforAwsIamUser[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_iam_user"
    label := concat(".", resource.Labels)
}

isValidResourceAttached{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_iam_group_membership"
    awsIamGroupLabel := getTheLabelforAwsIamGroup[_]
    awsIamUserLabel := getTheLabelforAwsIamUser[_]
    contains(resource.Attributes.group, awsIamGroupLabel)
    contains(resource.Attributes.users, awsIamUserLabel)
}

pass[resource]{
    resource := input[_]
    isvalid(resource)
    isValidResourceAttached
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "A minimum of one IAM user is present in IAM groups.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "For each IAM group, a minimum of one IAM user must be present.",
                "snippet": block }
} 