# METADATA
# title: "Verify that S3 bucket has lock configuration enabled by default"
# description: "By enabling the lock configuration on an S3 bucket, it ensures that critical objects stored within the bucket are protected from accidental or malicious deletion or modification, providing an added layer of data integrity and compliance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#object_lock_configuration
# custom:
#   id: CB_TFAWS_147
#   severity: LOW
package lib.terraform.CB_TFAWS_147

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_s3_bucket"
    block.Blocks[_].Type == "object_lock_configuration"
    has_attribute(block.Blocks[_].Attributes, "object_lock_enabled")
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
    resource.Blocks[_].Attributes.object_lock_enabled == "Enabled"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_s3_bucket' for 'object_lock_configuration' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_s3_bucket' for 'object_lock_configuration' should be set.",
                "snippet": block }
} 