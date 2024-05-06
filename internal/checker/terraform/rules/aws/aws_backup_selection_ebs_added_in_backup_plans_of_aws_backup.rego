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

getthelabelforawsebs_volume contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_ebs_volume" in resource.Labels
	label := concat(".", resource.Labels)
}

is_valid_resource_attached if {
	some resource in input
	resource.Type == "resource"
	"aws_backup_selection" in resource.Labels
	some resources in resource.Attributes.resources
	some label in getthelabelforawsebs_volume
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
		"message": "The AWS Backup includes Elastic Block Store (EBS) volumes within its backup plans.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "The AWS Backup must include Elastic Block Store (EBS) volumes within its backup plans.",
		"snippet": block,
	}
}
