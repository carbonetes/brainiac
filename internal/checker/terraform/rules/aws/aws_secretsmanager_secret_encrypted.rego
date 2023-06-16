# METADATA
# title: The Secrets Manager secret must be encrypted with KMS CMK"
# description: "Using the AWS-managed key aws/secretsmanager, secrets manager secrets are by default encrypted. Specifically supplying a customer managed key to use as an alternative is recommended."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret.html
# custom:
#   id: CB_TFAWS_124
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_124

import future.keywords.in 

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_secretsmanager_secret"
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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "kms_key_id")
    not contains(resource.Attributes.kms_key_id, "aws/")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_secretsmanager_secret' is encrypted.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_secretsmanager_secret' should be encrypted.",
                "snippet": block }
}
