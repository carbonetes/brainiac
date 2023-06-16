# METADATA
# title: "Verify that RDS instances has backup policy"
# description: "By having a backup policy in place, you can mitigate the risk of data loss and facilitate the restoration of your databases in case of any unforeseen events or failures."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
# custom:
#   id: CB_TFAWS_131
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_131

supportedResources := ["aws_db_instance", "aws_rds_cluster"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource] {
    resource := input[_]
    isvalid(resource)
    backupPeriod := to_number(resource.Attributes.backup_retention_period)
    backupPeriod > 0
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "RDS instances has backup policy",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "RDS instances should have set backup policy",
                "snippet": block}
}
