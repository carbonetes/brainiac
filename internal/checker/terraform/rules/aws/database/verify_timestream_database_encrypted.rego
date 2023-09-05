# METADATA
# title: "Verify that Timestream database is encrypted with KMS CMK"
# description: "By encrypting the Timestream database with a KMS CMK, data at rest is safeguarded against unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/timestreamwrite_database
# custom:
#   id: CB_TFAWS_138
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_138

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_timestreamwrite_database"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

has_attribute(key, value) {
  _ = key[value]
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "kms_key_id")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_timestreamwrite_database' encryption is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_timestreamwrite_database' should be ecnrypted.",
                "snippet": block }
}
