# METADATA
# title: "Confirm that Fine-Grained Access Control is Activated for AWS ElasticSearch/OpenSearch"
# description: "Verify that AWS ElasticSearch/OpenSearch is configured with fine-grained access control enabled. This security measure enhances data protection by enforcing precise access permissions to the Elasticsearch/OpenSearch resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain
# custom:
#   id: CB_TFAWS_353
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_353

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
    block.Type == "advanced_security_options"
    block.Attributes.enabled == true
    block.Attributes.internal_user_database_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The Fine-Grained Access Control is Activated for AWS ElasticSearch/OpenSearch.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "The Fine-Grained Access Control must Activated for AWS ElasticSearch/OpenSearch.",
                "snippet": block }
}
