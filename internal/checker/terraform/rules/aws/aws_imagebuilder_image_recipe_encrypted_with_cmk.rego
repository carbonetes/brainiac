# METADATA
# title: "Confirm that the Image Recipe EBS Disks are CMK encrypted"
# description: "In accordance with this policy, Image Recipe EBS Disks that use default KMS keys rather than customer-managed keys for encryption are identified. To encrypt your EFS data, it is recommended that you utilize customer-managed KMS Keys. You are granted total control on the encrypted data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/imagebuilder_image_recipe
# custom:
#   id: CB_TFAWS_191
#   severity: LOW
package lib.terraform.CB_TFAWS_191

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_imagebuilder_image_recipe"
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

fail[resource] {
    expectedValues := ["encrypted", "kms_key_id"]
    expectedValue = expectedValues[_]
    resource := input[_]
    isvalid(resource)  
    blocks := resource.Blocks[_]
    nestedBlocks := blocks.Blocks[_]
    not has_attribute(nestedBlocks.Attributes, expectedValue)    
}

passed[result] {
	block := pass[_]
	result := { "message": "Image Recipe EBS Disks are CMK encrypted.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Image Recipe EBS Disks must be CMK encrypted.",
                "snippet": block }
} 