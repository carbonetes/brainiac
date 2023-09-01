# METADATA
# title: "Verify all data stored in the Elasticsearch is encrypted with a CMK."
# description: "By encrypting data stored in the Elasticsearch domain with a Customer Managed Key (CMK), sensitive information remains secure and protected from unauthorized access, ensuring compliance with security standards and safeguarding the integrity of the system."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain
# custom:
#   id: CB_TFAWS_278
#   severity: LOW
package lib.terraform.CB_TFAWS_278

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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "encrypt_at_rest"
    resource.Blocks[_].Attributes.kms_key_id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The data stored in the Elasticsearch is encrypted with a CMK.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The data stored in the Elasticsearch is not encrypted with a CMK.",
                "snippet": block }
} 