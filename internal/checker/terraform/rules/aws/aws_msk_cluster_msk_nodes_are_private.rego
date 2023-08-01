# METADATA
# title: "Guarantee the privacy of MSK nodes"
# description: "This check ensures that the nodes in Amazon Managed Streaming for Apache Kafka are configured as private to enhance the security and prevent unauthorized access to the cluster."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/msk_cluster
# custom:
#   id: CB_TFAWS_270
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_270

import future.keywords.in 

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_msk_cluster"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
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
	resource.Blocks[_].Type == "broker_node_group_info"
	resource.Blocks[_].Blocks[_].Type == "connectivity_info"
	resource.Blocks[_].Blocks[_].Blocks[_].Type == "public_access"
	resource.Blocks[_].Blocks[_].Blocks[_].Attributes.type == "SERVICE_PROVIDED_EIPS"
}

passed[result] {
	block := pass[_]
	result := { "message": "MSK nodes are configured as private.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "MSK nodes must be configured as private.",
                "snippet": block}
}


