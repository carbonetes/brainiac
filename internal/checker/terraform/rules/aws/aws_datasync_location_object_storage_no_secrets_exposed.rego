# METADATA
# title: "Verify that DataSync Location Object Storage does not reveal sensitive information"
# description: "This check examines the DataSync Location Object Storage configuration to prevent any exposure of sensitive information or secrets."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/datasync_location_object_storage
# custom:
#   id: CB_TFAWS_286
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_286

import future.keywords.in 

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_datasync_location_object_storage"
}

has_attribute(key, value) {
    _ = key[value]
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
    has_attribute(resource.Attributes, "secret_key")
   
}

passed[result] {
	block := pass[_]
	result := { "message": "DataSync Location Object Storage does not reveal secrets.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "DataSync Location Object Storage must not reveal secrets.",
                "snippet": block }
}
