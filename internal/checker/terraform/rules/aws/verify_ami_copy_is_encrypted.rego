# METADATA
# title: "Verify that copied AMIs are encrypted"
# description: "By encrypting the copied AMIs, sensitive data stored within the images remains protected, ensuring the security and confidentiality of the resources deployed from those AMIs."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami_copy#encrypted
# custom:
#   id: CB_TFAWS_223
#   severity: LOW
package lib.terraform.CB_TFAWS_223

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ami_copy"
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
    resource.Attributes.encrypted == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "AMI copy is encrypted",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "AMI copy should be encrypted",
                "snippet": block }
}
