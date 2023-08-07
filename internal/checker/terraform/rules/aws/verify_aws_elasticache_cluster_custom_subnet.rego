# METADATA
# title: "Verify that ElastiCache clusters do not use the default subnet group"
# description: "By specifying a custom subnet group for the ElastiCache cluster, we ensure optimal network placement and security, enhancing performance and isolation within the AWS infrastructure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster
# custom:
#   id: CB_TFAWS_311
#   severity: LOW
package lib.terraform.CB_TFAWS_311

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_elasticache_cluster"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource] {
	resource := input[_]
	resource.Attributes.subnet_group_name != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "ElastiCache clusters does not use the default subnet group.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "ElastiCache clusters should not use the default subnet group.",
                "snippet": block }
} 