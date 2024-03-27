# METADATA
# title: "Be certain to include Elastic File System (Amazon EFS) file systems in the backup plans of AWS Backup"
# description: "By establishing a backup strategy, you can guarantee that your data is consistently backed up and can be restored if data is lost or corrupted."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection.html
# custom:
#   id: CB_TFAWS_351
#   severity: LOW
package lib.terraform.CB_TFAWS_351

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_backup_selection"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getthelabelforawsefsfilesystem contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_efs_file_system" in resource.Labels
	label := concat(".", resource.Labels)
}

is_valid_resource_attached if {
	some resource in input
	resource.Type == "resource"
	"aws_backup_selection" in resource.Labels
	some resources in resource.Attributes.resources
	some label in getthelabelforawsefsfilesystem
	contains(resources, label)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Elastic File System (Amazon EFS) file systems in the backup plans of AWS Backup is included.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Elastic File System (Amazon EFS) file systems in the backup plans of AWS Backup must be included.",
		"snippet": block,
	}
}
