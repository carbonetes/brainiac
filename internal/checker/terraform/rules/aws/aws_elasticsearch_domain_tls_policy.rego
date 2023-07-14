# METADATA
# title: "Ensure that Elasticsearch domain is using an up to date TLS policy"
# description: "By enforcing an up-to-date TLS policy for the Elasticsearch domain, data exchanged between clients and the domain is secured with the latest cryptographic protocols, ensuring the confidentiality and integrity of sensitive information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain#domain_endpoint_options
# custom:
#   id: CB_TFAWS_215
#   severity: LOW
package lib.terraform.CB_TFAWS_215

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
    resource.Blocks[_].Attributes.tls_security_policy != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Elasticsearch domain is using an up to date TLS policy.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Elasticsearch domain is not using an up to date TLS policy.",
                "snippet": block }
}
