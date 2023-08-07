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

import future.keywords.if

supportedResource := ["aws_elasticsearch_domain", "aws_opensearch_domain"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
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
	resource.Blocks[_].Type == "cluster_config"
    to_number(resource.Blocks[_].Attributes.dedicated_master_count) >= 3
    resource.Blocks[_].Attributes.zone_awareness_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Elasticsearch domains are configured with at least three dedicated master nodes for HA.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Elasticsearch domains should be configured with at least three dedicated master nodes for HA.",
                "snippet": block }
} 