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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_imagebuilder_image_recipe"
}

has_attribute(key, value) if {
    value in object.keys(key)
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains resource if {
	some resource in input
    isvalid(resource)
    expectedvalues := ["encrypted", "kms_key_id"]
    some expectedvalue in expectedvalues
    some block in resource.Blocks
    some nestedblocks in block.Blocks
    not has_attribute(nestedblocks.Attributes, expectedvalue) 
   
}

pass contains block if {
    some block in input
	isvalid(block)
   	not fail[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Image Recipe EBS Disks are CMK encrypted.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Image Recipe EBS Disks must be CMK encrypted.",
                "snippet": block }
} 