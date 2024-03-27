# METADATA
# title: "Verify ElasticSearch/OpenSearch has dedicated master node enabled"
# description: "By enabling dedicated master nodes, you ensure that cluster management tasks are segregated from data and query processing, leading to improved cluster stability and responsiveness."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain#cluster_config
# custom:
#   id: CB_TFAWS_359
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_359

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := ["aws_elasticsearch_domain", "aws_opensearch_domain"]
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
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "cluster_config"
	block.Attributes.dedicated_master_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "ElasticSearch/OpenSearch has dedicated master node enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": " ElasticSearch/OpenSearch should have dedicated master node enabled.",
		"snippet": block,
	}
}
