# METADATA
# title: "Enable encryption for EBS volumes by default"
# description: "This ensures that all EBS volumes are encrypted by default."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_encryption_by_default
# custom:
#   id: CB_TFAWS_003
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_003

import future.keywords.in 


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ebs_volume"
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
    resource.Attributes.encrypted == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_ebs_volume' 'encrypted' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_ebs_volume' 'encrypted' should be set to true",
                "snippet": block }
} 