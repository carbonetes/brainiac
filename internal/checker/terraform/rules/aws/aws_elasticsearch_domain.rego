# METADATA
# title: "Make sure node-to-node encryption is enabled for all instances of Elasticsearch"
# description: "By using node-to-node encryption, you can make sure that any data you provide over HTTPS to your Amazon Elasticsearch Service domain is kept secure as it is disseminated and replicated across the nodes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain
# custom:
#   id: CB_TFAWS_005
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_005

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_elasticsearch_domain", "aws_opensearch_domain"]
	label in supportedresource
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
    block.Type == "node_to_node_encryption_options"
    block.Attributes.enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := { "message": "node-to-node encryption is enabled.",
                "snippet": block}
}

failed contains result if {
	some block in fail
	result := { "message": "node-to-node encryption is disabled.",
                "snippet": block }
}
