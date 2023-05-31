# METADATA
# title: "Check to see if DAX is encrypted at rest (the default is unencrypted)."
# description: "For the purpose of managing the single service default key used to encrypt clusters, DAX encryption at rest seamlessly connects with AWS KMS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dax_cluster
# custom:
#   id: CB_TFAWS_041
#   severity: HIGH
package lib.terraform.CB_TFAWS_041

import future.keywords.in 

supportedResource := ["aws_dax_cluster"]

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
    block.Type == "server_side_encryption"
    block.Attributes.enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "aws_dax_cluster_encrypted is set to true.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "aws_dax_cluster_encrypted should be set to true.",
                "snippet": block }
}
