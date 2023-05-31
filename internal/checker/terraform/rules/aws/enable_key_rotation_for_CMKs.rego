# METADATA
# title: "Enable key rotation for customer-created Customer Master Keys (CMKs)"
# description: "This reduces the risk of compromised keys as well as the amount of time an attacker has to exploit any vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key#enable_key_rotation
# custom:
#   id: CB_TFAWS_006
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_006

import future.keywords.in 


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_kms_key"
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
    resource.Attributes.enable_key_rotation == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_kms_key' 'enable_key_rotation' is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_kms_key' 'enable_key_rotation' should be set to true",
                "snippet": block }
}