# METADATA
# title: "Check to see if the AWS Backup of RDS clusters have a backup plan"
# description: "With the help of an automatically created backup to a safe, long-lasting storage location, AWS Backup is a completely managed backup solution that aids in protecting your data in the cloud."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/rds_cluster.html
# custom:
#   id: CB_TFAWS_330
#   severity: LOW
package lib.terraform.CB_TFAWS_330

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_rds_cluster"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getthelabelforawsrdscluster contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_rds_cluster" in resource.Labels
	label := concat(".", resource.Labels)
}

is_valid_resource_attached if {
	some resource in input
	resource.Type == "resource"
	"aws_backup_selection" in resource.Labels
	some resources in resource.Attributes.resources
	some label in getthelabelforawsrdscluster
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
		"message": "The AWS Backup of RDS clusters have a backup plan.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "The AWS Backup of RDS clusters must have a backup plan.",
		"snippet": block,
	}
}
