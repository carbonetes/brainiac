# METADATA
# title: "Verify MSK Cluster encryption in rest and transit is enabled"
# description: "By enabling both encryption at rest and in transit for your MSK cluster, you significantly enhance the security posture of your Kafka infrastructure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster.html
# custom:
#   id: CB_TFAWS_093
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_093

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

fail[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "encryption_info"
    block.Blocks[_].Type == "encryption_in_transit"
    block.Blocks[_].Attributes.client_broker != "TLS"
}
fail[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "encryption_info"
    block.Blocks[_].Type == "encryption_in_transit"
    block.Blocks[_].Attributes.in_cluster == false
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_msk_cluster' encryption is set properly",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_msk_cluster' encryption should be set properly at rest and transit",
                "snippet": block }
}
