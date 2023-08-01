# METADATA
# title: "Verify that Elasticsearch is not using the default Security Group."
# description: "By customizing the VPC options and security group IDs for the Elasticsearch domain, we ensure that the Elasticsearch service is securely integrated within our own VPC network, providing better control and isolation over access to the service, enhancing overall security and compliance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain#security_group_ids
# custom:
#   id: CB_TFAWS_279
#   severity: LOW
package lib.terraform.CB_TFAWS_279

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
    resource.Blocks[_].Type == "vpc_options"
    is_array(resource.Blocks[_].Attributes.security_group_ids)
    count(resource.Blocks[_].Attributes.security_group_ids) > 0
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Elasticsearch is not using the default Security Group.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Elasticsearch must not use the default Security Group.",
                "snippet": block }
} 