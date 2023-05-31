# METADATA
# title: "AWS Kinesis streams must be encrypted"
# description: "We advise you to make sure server-side encryption (SSE) is used to encrypt Kinesis streams."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_stream
# custom:
#   id: CB_TFAWS_027
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_027

import future.keywords.in 

supportedResource := ["aws_kinesis_stream"]
valid_encryption_types = ["KMS", "NONE"]


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.encryption_type == valid_encryption_types[_]
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "aws_kinesis_stream is encrypted.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "aws_kinesis_stream should be encrypted.",
                "snippet": block}
}
