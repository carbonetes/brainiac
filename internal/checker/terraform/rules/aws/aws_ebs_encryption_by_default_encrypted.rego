# METADATA
# title: "Verify that EBS default encryption is active"
# description: Enabling encryption for data at rest minimizes the risk of unintended disclosure of data stored in EBS volumes."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_encryption_by_default
# custom:
#   id: CB_TFAWS_069
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_069

import future.keywords.in 


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ebs_encryption_by_default"
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
    resource.Attributes.enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Default encryption for EBS is active.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Default encryption for EBS should be active.",
                "snippet": block}
}
