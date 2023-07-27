# METADATA
# title: "Verify Keyspaces Table uses CMK"
# description: "By utilizing a CMK, you gain more control over the encryption keys and their management, which enhances the security and compliance of your sensitive data stored in Keyspaces tables."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/keyspaces_table#encryption_specification
# custom:
#   id: CB_TFAWS_260
#   severity: LOW
package lib.terraform.CB_TFAWS_260

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_keyspaces_table"
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
    resource.Blocks[_].Type == "encryption_specification"
    resource.Blocks[_].Attributes.kms_key_identifier != ""
    resource.Blocks[_].Attributes.type == "CUSTOMER_MANAGED_KEY"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Keyspaces Table uses CMK.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Keyspaces Table must use CMK.",
                "snippet": block }
} 