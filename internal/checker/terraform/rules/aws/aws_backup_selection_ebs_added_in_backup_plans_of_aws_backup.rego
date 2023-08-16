# METADATA
# title: "Make certain that AWS Backup includes Elastic Block Store (EBS) volumes within its backup plans"
# description: "Integrate EBS volumes into your AWS Backup strategies. Through the formulation of a backup plan, you can establish a routine for protecting your data, facilitating restoration should data loss or corruption arise."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection.html
# custom:
#   id: CB_TFAWS_338
#   severity: LOW
package lib.terraform.CB_TFAWS_338

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_backup_selection"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getTheLabelforAwsEBS_volume[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_ebs_volume"
    label := concat(".", resource.Labels)
}

isValidResourceAttached{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_backup_selection"
    resources := resource.Attributes.resources[_]
    contains(resources, getTheLabelforAwsEBS_volume[_])
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
	result := { "message": "The AWS Backup includes Elastic Block Store (EBS) volumes within its backup plans.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The AWS Backup must include Elastic Block Store (EBS) volumes within its backup plans.",
                "snippet": block }
} 