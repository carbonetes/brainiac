# METADATA
# title: "Make certain that Glue Security Configuration Encryption is activated"
# description: "Three AWS glue components, including Cloudwatch, job bookmarks, and S3 buckets, have the potential to be encrypted. This check guarantees that each is properly set."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/4.8.0/docs/resources/glue_security_configuration
# custom:
#   id: CB_TFAWS_107
#   severity: HIGH
package lib.terraform.CB_TFAWS_107

import future.keywords.in 

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_glue_security_configuration"
}

has_attribute (key, value) {
    _ = key[value]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[block]{
    block := input[_]
    isvalid(block)
    encryptionConfig := block.Blocks[_]
    encryptionConfig.Type == "encryption_configuration"
    encryptionConfig.Blocks[_].Type == "cloudwatch_encryption"
    encryptionConfig.Blocks[_].Type == "job_bookmarks_encryption"
    encryptionConfig.Blocks[_].Type == "s3_encryption"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}


passed[result] {
	block := pass[_]
	result := { "message": "'aws_glue_security_configuration' is encrypted.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_glue_security_configuration' should be encrypted.",
                "snippet": block}
}
