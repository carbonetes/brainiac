# METADATA
# title: "Verify Cluster logging with CMK"
# description: "This ensures that only authorized individuals or systems can access and decrypt the logs, protecting the confidentiality and integrity of the information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster#configuration
# custom:
#   id: CB_TFAWS_217
#   severity: LOW
package lib.terraform.CB_TFAWS_217

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ecs_cluster"
}

has_attribute(key, value) {
  _ = key[value]
}

isLogConfigExist(blocks){
	blocks.Blocks[_].Type == "configuration"
    blocks.Blocks[_].Blocks[_].Type == "execute_command_configuration"
    not hasNoneLogging(blocks)
}
hasNoneLogging(blocks){
    blocks.Blocks[_].Blocks[_].Attributes.logging == "NONE"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[blocks]{
    blocks := input[_]
	isvalid(blocks)
    isLogConfigExist(blocks)
    has_attribute(blocks.Blocks[_].Blocks[_].Attributes, "kms_key_id")
    blocks.Blocks[_].Blocks[_].Blocks[_].Type == "log_configuration"
    blocks.Blocks[_].Blocks[_].Blocks[_].Attributes.cloud_watch_encryption_enabled == true
}

pass[blocks]{
    blocks := input[_]
	isvalid(blocks)
    isLogConfigExist(blocks)
    has_attribute(blocks.Blocks[_].Blocks[_].Attributes, "kms_key_id")
    blocks.Blocks[_].Blocks[_].Blocks[_].Type == "log_configuration"
    blocks.Blocks[_].Blocks[_].Blocks[_].Attributes.s3_bucket_encryption_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
    isLogConfigExist(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "ECS cluster logging with CMK is set properly",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "ECS cluster logging with CMK should be set",
                "snippet": block }
} 