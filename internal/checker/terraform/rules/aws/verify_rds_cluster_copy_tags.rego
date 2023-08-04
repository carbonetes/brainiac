# METADATA
# title: "Verify that RDS cluster configured to copy tags to snapshots"
# description: "By enabling the `copy_tags_to_snapshot` property in the AWS RDS Cluster configuration, it ensures that critical metadata and context provided by tags are retained during snapshot creation, facilitating better management, and enhancing data recovery processes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster
# custom:
#   id: CB_TFAWS_296
#   severity: LOW
package lib.terraform.CB_TFAWS_296

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_rds_cluster"
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.copy_tags_to_snapshot == true
}

fail[resource] {
    resource := input[_]
    isvalid(resource)
    not pass[resource]
}

passed[result] {
	block := pass[_]
	result := { "message": "RDS cluster configured to copy tags to snapshots.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "RDS cluster must be configured to copy tags to snapshots.",
                "snippet": block }
} 