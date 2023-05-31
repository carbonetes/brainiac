# METADATA
# title: "Enable encryption at rest for ElastiCache Replication Groups"
# description: "ElastiCache Replication Groups should have encryption at rest enabled to protect sensitive data. By default, ElastiCache Replication Groups are not encrypted at rest. This can be remediated by setting the at_rest_encryption_enabled attribute to true."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group
# custom:
#   id: CB_TFAWS_017
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_017

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_elasticache_replication_group"
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
    resource.Attributes.at_rest_encryption_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_elasticache_replication_group' 'at_rest_encryption_enabled' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_elasticache_replication_group' 'at_rest_encryption_enabled' should be set to true",
                "snippet": block }
} 