# METADATA
# title: "Make sure that all data stored in Elasticsearch is encrypted securely while at rest."
# description: "This helps ensure that the data remains secure even if an attacker gains access to the storage medium where the data is stored."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain#encrypt_at_rest
# custom:
#   id: CB_TFAWS_004
#   severity: LOW
package lib.terraform.CB_TFAWS_004

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
    block.Type == "encrypt_at_rest"
    block.Attributes.enabled == true
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "encrypt_at_rest"
    block.Attributes.enabled == false
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "encrypt_at_rest is true.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "encrypt_at_rest should be set to true",
                "snippet": block }
}
