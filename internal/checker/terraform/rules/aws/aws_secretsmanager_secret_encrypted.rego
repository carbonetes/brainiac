# METADATA
# title: "The Secrets Manager secret must be encrypted with KMS CMK"
# description: "Using the AWS-managed key aws/secretsmanager, secrets manager secrets are by default encrypted. Specifically supplying a customer managed key to use as an alternative is recommended."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret.html
# custom:
#   id: CB_TFAWS_124
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_124
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_secretsmanager_secret"
}

has_attribute(key, value) if {
    value in object.keys(key)
}

resource contains resource if{
	some block in pass
	resource := concat(".", block.Labels)
} 
resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if{
    some resource in input
	isvalid(resource)
    has_attribute(resource.Attributes, "kms_key_id")
    not contains(resource.Attributes.kms_key_id, "aws/")
}

fail contains block if {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_secretsmanager_secret' is encrypted.",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_secretsmanager_secret' should be encrypted.",
                "snippet": block }
}
