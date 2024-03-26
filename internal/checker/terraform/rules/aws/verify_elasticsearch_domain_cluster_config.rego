# METADATA
# title: "Verify that Elasticsearch domains are configured with at least three dedicated master nodes for HA"
# description: "By configuring Elasticsearch domains with at least three dedicated master nodes for high availability, you ensure a resilient and fault-tolerant cluster that can handle failures and maintain data integrity."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain
# custom:
#   id: CB_TFAWS_306
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_306

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	supported_resources := ["aws_elasticsearch_domain", "aws_opensearch_domain"]
	some label in block.Labels
	label in supported_resources
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	some cluster in resource.Blocks
	cluster.Type == "cluster_config"
	to_number(cluster.Attributes.dedicated_master_count) >= 3
	cluster.Attributes.zone_awareness_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Elasticsearch domains are configured with at least three dedicated master nodes for HA.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Elasticsearch domains should be configured with at least three dedicated master nodes for HA.",
		"snippet": block,
	}
}
