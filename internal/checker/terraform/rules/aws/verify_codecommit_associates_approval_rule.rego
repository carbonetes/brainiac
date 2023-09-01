# METADATA
# title: "Verify Codecommit associates an approval rule"
# description: "This guarantees that authorized team members review and approve modifications, enhancing code quality and security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codecommit_approval_rule_template_association
# custom:
#   id: CB_TFAWS_344
#   severity: LOW
package lib.terraform.CB_TFAWS_344

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_codecommit_repository"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getCodeCommitRepoLabel[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_codecommit_repository"
    label := concat(".", resource.Labels)
}

getIsCodeCommitApprovalAttached{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_codecommit_approval_rule_template_association"
    contains(resource.Attributes.repository_name, getCodeCommitRepoLabel[_])
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    getIsCodeCommitApprovalAttached
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Codecommit associates an approval rule.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Codecommit should associates an approval rule.",
                "snippet": block }
} 