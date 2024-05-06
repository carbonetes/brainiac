# METADATA
# title: "Verify that RDS instances has backup policy"
# description: "By having a backup policy in place, you can mitigate the risk of data loss and facilitate the restoration of your databases in case of any unforeseen events or failures."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
# custom:
#   id: CB_TFAWS_131
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_131
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    supported_resource := ["aws_db_instance", "aws_rds_cluster"]
    label in supported_resource
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 
resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if{
    some resource in input
    isvalid(resource)
    backup_period := to_number(resource.Attributes.backup_retention_period)
    backup_period > 0
}

fail contains block if {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "RDS instances has backup policy",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "RDS instances should have set backup policy",
                "snippet": block}
}
