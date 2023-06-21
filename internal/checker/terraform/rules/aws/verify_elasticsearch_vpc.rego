# METADATA
# title: "Verify that Elasticsearch is configured inside a VPC"
# description: "By configuring Elasticsearch inside a VPC, you can ensure secure and private communication, leveraging VPC networking capabilities while protecting sensitive data and enhancing network isolation."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain#vpc_options
# custom:
#   id: CB_TFAWS_140
#   severity: LOW
package lib.terraform.CB_TFAWS_140

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
    isvalid(resource)
    resource.Blocks[_].Type == "vpc_options"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_elasticsearch_domain' or 'aws_opensearch_domain' for 'vpc_options' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_elasticsearch_domain' or 'aws_opensearch_domain' for 'vpc_options' should be set.",
                "snippet": block }
} 