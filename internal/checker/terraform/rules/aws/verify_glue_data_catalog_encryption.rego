# METADATA
# title: "Verify that Glue Data Catalog Encryption is enabled"
# description: "By enabling Glue Data Catalog encryption, you can secure sensitive data and ensure the confidentiality of connections and metadata in your AWS environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_data_catalog_encryption_settings
# custom:
#   id: CB_TFAWS_105
#   severity: HIGH
package lib.terraform.CB_TFAWS_105

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_glue_data_catalog_encryption_settings"
}

has_attribute(key, value) if {
	value in object.keys(key)
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
    some resource in input
    isvalid(resource)
    data_catalog_encryption_settings := block_check(resource.Blocks, "data_catalog_encryption_settings")
    
    encryption_at_rest := block_check(data_catalog_encryption_settings.Blocks, "encryption_at_rest")
    has_attribute(encryption_at_rest.Attributes, "catalog_encryption_mode")
    encryption_at_rest.Attributes.catalog_encryption_mode == "SSE-KMS"
    has_attribute(encryption_at_rest.Attributes, "sse_aws_kms_key_id")
    
    connection_password_encryption := block_check(data_catalog_encryption_settings.Blocks, "connection_password_encryption")
    has_attribute(connection_password_encryption.Attributes, "return_connection_password_encrypted")
    connection_password_encryption.Attributes.return_connection_password_encrypted == true
    has_attribute(connection_password_encryption.Attributes, "aws_kms_key_id")
}

block_check(blocks, key) := result if {
    some block in blocks
    block.Type == key
    result := block
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_glue_data_catalog_encryption_settings' for 'encryption_at_rest' and 'connection_password_encryption' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_glue_data_catalog_encryption_settings' for 'encryption_at_rest' and 'connection_password_encryption' should be set.",
		"snippet": block,
	}
}