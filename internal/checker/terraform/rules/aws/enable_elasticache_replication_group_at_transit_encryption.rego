# METADATA
# title: "Enable Encryption at transit for ElastiCache Replication Groups"
# description: "Transit encryption is the process of encrypting information as it moves between two endpoints. This is important because it protects the information as it is transmitted from one endpoint to another. If the information is not encrypted, it can be intercepted and read by an attacker."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group
# custom:
#   id: CB_TFAWS_020
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_020

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
    resource.Attributes.transit_encryption_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_elasticache_replication_group' 'transit_encryption_enabled' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_elasticache_replication_group' 'transit_encryption_enabled' should be set to true",
                "snippet": block }
} 