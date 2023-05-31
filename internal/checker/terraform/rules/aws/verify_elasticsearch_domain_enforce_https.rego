# METADATA
# title: "Verify that Elasticsearch Domain enforces HTTPS"
# description: "By enforcing HTTPS, the Elasticsearch Domain guarantees secure communication and data transfer, ensuring the encryption of sensitive information and preventing unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain
# custom:
#   id: CB_TFAWS_068
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_068

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

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "domain_endpoint_options"
    resource.Blocks[_].Attributes.enforce_https == false
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_elasticsearch_domain' or 'aws_opensearch_domain' for 'enforce_https' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_elasticsearch_domain' 'aws_opensearch_domain' for 'enforce_https' should be set.",
                "snippet": block }
} 