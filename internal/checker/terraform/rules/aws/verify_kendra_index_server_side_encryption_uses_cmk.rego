# METADATA
# title: "Verify Kendra index Server side encryption uses CMK"
# description: "By utilizing a CMK, you can have granular control over the encryption keys and their lifecycle, ensuring better security for your Kendra indexes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kendra_index
# custom:
#   id: CB_TFAWS_255
#   severity: LOW
package lib.terraform.CB_TFAWS_255

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_kendra_index"
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
    resource.Blocks[_].Type == "server_side_encryption_configuration"
    resource.Blocks[_].Attributes.kms_key_id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Kendra index Server side encryption uses CMK.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Kendra index Server side encryption must use CMK.",
                "snippet": block }
} 