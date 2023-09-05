# METADATA
# title: "Verify that ElastiCache for Redis cache clusters have auto minor version upgrades enabled"
# description: "By enabling the `auto_minor_version_upgrade` property for the AWS Elasticache Memcached cluster, we ensure that the cluster automatically upgrades to minor versions during maintenance windows, thereby ensuring security patches and performance improvements are promptly applied without manual intervention."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster
# custom:
#   id: CB_TFAWS_310
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_310

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

fail[resource] {
	resource := input[_]
	resource.Attributes.auto_minor_version_upgrade == false
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "ElastiCache for Redis cache clusters have auto minor version upgrades enabled.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "ElastiCache for Redis cache clusters does not have auto minor version upgrades enabled.",
                "snippet": block }
} 