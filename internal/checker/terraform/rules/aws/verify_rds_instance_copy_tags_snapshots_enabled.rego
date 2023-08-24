# METADATA
# title: "Verify RDS instance with copy tags to snapshots is enabled"
# description: "Enabling this feature helps maintain consistent metadata and context between the RDS instances and their snapshots."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#copy_tags_to_snapshot
# custom:
#   id: CB_TFAWS_360
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_360
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_db_instance"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.copy_tags_to_snapshot == true
    invalidEngine := ["neptune", "aurora", "docdb"]
    not resource.Attributes.engine in invalidEngine
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "RDS instance copy tags to snapshots is enabled",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "RDS instance copy tags to snapshots should be enabled.",
                "snippet": block }
}
