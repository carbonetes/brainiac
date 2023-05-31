# METADATA
# title: "Enable Encryption at transit with auth_token for ElastiCache Replication Groups"
# description: "ElastiCache Replication Groups should be encrypted at transit with auth_token to ensure that the data is not exposed to any unauthorized users."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group
# custom:
#   id: CB_TFAWS_022
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_022

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_elasticache_replication_group"
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
    resource.Attributes.transit_encryption_enabled == true
    has_attribute(resource.Attributes, "auth_token")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_elasticache_replication_group' 'transit_encryption_enabled' and 'auth_token' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_elasticache_replication_group' 'transit_encryption_enabled' and 'auth_token' should be set to true",
                "snippet": block }
} 