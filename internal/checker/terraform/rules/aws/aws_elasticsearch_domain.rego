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

import future.keywords.in 

supportedResource := ["aws_elasticsearch_domain", "aws_opensearch_domain"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "node_to_node_encryption_options"
    block.Attributes.enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "node-to-node encryption is enabled.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "node-to-node encryption is disabled.",
                "snippet": block }
}
