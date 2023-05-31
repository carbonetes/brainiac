# METADATA
# title: "Make sure that the neptune storage is encrypted in a secure manner"
# description: "Data and metadata stored on Neptune are shielded from unauthorized access by encryption."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/neptune/latest/userguide/encrypt-ssl-connections.html
# custom:
#   id: CB_TFAWS_025
#   severity: LOW
package lib.terraform.CB_TFAWS_025

import future.keywords.in 

supportedResource := ["aws_neptune_cluster"]

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


pass[resource] {
    resource := input[_]
    isvalid(resource)
    resource.Attributes.storage_encrypted == true
   
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "storage_encrypted is set to true.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "storage_encrypted should be set to true.",
                "snippet": block}
}
