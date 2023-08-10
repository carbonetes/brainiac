# METADATA
# title: "Make certain that EC2 instances only have encrypted EBS volumes attached"
# description: "Your data is better protected from unauthorized access or manipulation if your AWS EBS volumes are encrypted. You can make sure that only authorized people may access and change the data on your volumes in this way. Taking this precaution can assist defend against internal hazards like unintentional or unlawful access as well as external threats like hackers or malware."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume
# custom:
#   id: CB_TFAWS_323
#   severity: LOW
package lib.terraform.CB_TFAWS_323

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ebs_volume"
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

AWSVolumeAttachmentVolumeId{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_volume_attachment"
    resource.Attributes.volume_id == "aws_ebs_volume.ok_ebs2.id"
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    AWSVolumeAttachmentVolumeId
    has_attribute(resource.Attributes, "encrypted")
    resource.Attributes.encrypted == false
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "EC2 instances have encrypted EBS volumes attached.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Only encrypted EBS volumes can be attached to EC2 instances.",
                "snippet": block }
} 