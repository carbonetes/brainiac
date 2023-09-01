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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_glue_data_catalog_encryption_settings"
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
    data_catalog_encryption_settings := block_check(resource.Blocks[_], "data_catalog_encryption_settings")

    encryption_at_rest := block_check(data_catalog_encryption_settings.Blocks[_], "encryption_at_rest")
    has_attribute(encryption_at_rest.Attributes, "catalog_encryption_mode")
    encryption_at_rest.Attributes.catalog_encryption_mode == "SSE-KMS"
    has_attribute(encryption_at_rest.Attributes, "sse_aws_kms_key_id")

    connection_password_encryption := block_check(data_catalog_encryption_settings.Blocks[_], "connection_password_encryption")
    has_attribute(connection_password_encryption.Attributes, "return_connection_password_encrypted")
    connection_password_encryption.Attributes.return_connection_password_encrypted == true
    has_attribute(connection_password_encryption.Attributes, "aws_kms_key_id")
}

block_check(block, key) := result {
    block.Type == key
    result := block
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_glue_data_catalog_encryption_settings' for 'encryption_at_rest' and 'connection_password_encryption' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_glue_data_catalog_encryption_settings' for 'encryption_at_rest' and 'connection_password_encryption' should be set.",
                "snippet": block }
} 