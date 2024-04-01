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
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_ecs_cluster"
}

has_attribute(key, value) if {
	value in object.keys(key)
}

is_log_config_exist(blocks) if {
	some type in blocks.Blocks
	type.Type == "configuration"
	some block in type.Blocks
	block.Type == "execute_command_configuration"
	not has_none_logging(block)
}

has_none_logging(block) if {
	some block in block.Blocks.Blocks
	block.Attributes.kms_key_id.logging == "NONE"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains blocks if {
	some blocks in input
	isvalid(blocks)
	is_log_config_exist(blocks)
	some block in blocks.Blocks.Blocks
	has_attribute(block.Attributes, "kms_key_id")
	some nested_block in block.Blocks
	nested_block.Type == "log_configuration"
	nested_block.Attributes.cloud_watch_encryption_enabled == true
}

pass contains resource if {
        some resource in input
        isvalid(resource)
        some res in resource.Blocks
        some attribute in res.Blocks
        has_attribute(attribute.Attributes, "kms_key_id")
        some block in attribute.Blocks
        block.Type == "log_configuration"
        block.Attributes.s3_bucket_encryption_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	is_log_config_exist(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "ECS cluster logging with CMK is set properly",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "ECS cluster logging with CMK should be set",
		"snippet": block,
	}
}
