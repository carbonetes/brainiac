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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_rds_cluster"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

isValidResourceAttached{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_backup_selection"
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
	result := { "message": "The AWS Backup of RDS clusters have a backup plan.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The AWS Backup of RDS clusters must have a backup plan.",
                "snippet": block }
} 