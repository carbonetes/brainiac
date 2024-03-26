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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    supported_resource := ["aws_elasticsearch_domain", "aws_opensearch_domain"]
    label in supported_resource
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
}  

pass contains resource if {
    some resource in input
    isvalid(resource)
    resource.Blocks[_].Type == "vpc_options"
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_elasticsearch_domain' or 'aws_opensearch_domain' for 'vpc_options' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_elasticsearch_domain' or 'aws_opensearch_domain' for 'vpc_options' should be set.",
                "snippet": block }
}