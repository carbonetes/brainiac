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

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_elasticache_cluster"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains resource if {
	some resource in input
	resource.Attributes.auto_minor_version_upgrade == false
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "ElastiCache for Redis cache clusters have auto minor version upgrades enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "ElastiCache for Redis cache clusters does not have auto minor version upgrades enabled.",
		"snippet": block,
	}
}
