# METADATA
# title: "Enable and encrypt Session Manager logs"
# description: "Encrypting your ession Manager logs helps protect your data from unauthorized access or tampering."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_document
# custom:
#   id: CB_TFAWS_118
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_118

import future.keywords.in 


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ssm_document"
}

has_attribute(key, value){
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

pass[block] {
    block := input[_]
    isvalid(block)
    contentStr := block.Attributes.content
    contentParsed := json.unmarshal(contentStr)
    has_attribute(contentParsed.inputs, "s3BucketName")
    contentParsed.inputs.s3EncryptionEnabled == true
}

pass[block] {
    block := input[_]
    isvalid(block)
    contentStr := block.Attributes.content
    contentParsed := json.unmarshal(contentStr)
    has_attribute(contentParsed.inputs, "cloudWatchLogGroupName")
    contentParsed.inputs.cloudWatchEncryptionEnabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
    not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Session Manager logs are active and encrypted.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Session Manager logs should be active and encrypted.",
                "snippet": block}
}
