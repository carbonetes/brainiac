# METADATA
# title: "Verify that the Kinesis Video Stream Storage Config of the Connect Instance utilizes a Customer Managed Key (CMK) for encryption"
# description: "Validate that the Connect Instance's Kinesis Video Stream Storage Config is configured to use Customer Managed Keys (CMK) for encryption, ensuring compliance with security best practices."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/connect_instance_storage_config
# custom:
#   id: CB_TFAWS_244
#   severity: HIGH
package lib.terraform.CB_TFAWS_244

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_connect_instance_storage_config"
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

pass[resource] {
    resource := input[_]
    isvalid(resource)
    resource.Blocks[_].Type == "storage_config"
    resource.Blocks[_].Blocks[_].Type == "kinesis_video_stream_config"
    resource.Blocks[_].Blocks[_].Blocks[_].Type == "encryption_config"
    has_attribute(resource.Blocks[_].Blocks[_].Blocks[_].Attributes, "key_id")
    resource.Blocks[_].Blocks[_].Blocks[_].Attributes.key_id != ""
}




fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "CMK is being utilized by Connect Instance Kinesis Video Stream Storage Config.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "CMK must be utilized by Connect Instance Kinesis Video Stream Storage Config.",
                "snippet": block }
} 