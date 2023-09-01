# METADATA
# title: "Be certain to include Elastic File System (Amazon EFS) file systems in the backup plans of AWS Backup"
# description: "By establishing a backup strategy, you can guarantee that your data is consistently backed up and can be restored if data is lost or corrupted."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection.html
# custom:
#   id: CB_TFAWS_351
#   severity: LOW
package lib.terraform.CB_TFAWS_351

import future.keywords.if

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

getTheLabelForAwsEfsFileSystem[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_efs_file_system"
    label := concat(".", resource.Labels)
}

isValidResourceAttached{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_backup_selection"
    resources := resource.Attributes.resources[_]
    contains(resources, getTheLabelForAwsEfsFileSystem[_])
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
	result := { "message": "Elastic File System (Amazon EFS) file systems in the backup plans of AWS Backup is included.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Elastic File System (Amazon EFS) file systems in the backup plans of AWS Backup must be included.",
                "snippet": block }
} 