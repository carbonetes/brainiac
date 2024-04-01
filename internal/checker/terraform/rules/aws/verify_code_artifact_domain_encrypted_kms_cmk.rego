# METADATA
# title: "Verify Code artifact Domain is encrypted by KMS using a customer managed Key (CMK)"
# description: "By encrypting the CodeArtifact domain with a customer managed key, you can have greater control over the encryption process and ensure that only authorized users with the appropriate key can access and decrypt the artifacts."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codeartifact_repository_permissions_policy
# custom:
#   id: CB_TFAWS_212
#   severity: LOW
package lib.terraform.CB_TFAWS_212
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_codeartifact_domain"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

has_attribute(key, value) if {
    value in object.keys(key)
}

pass contains resource if {
    some resource in input
	isvalid(resource)
    has_attribute(resource.Attributes, "encryption_key")
    resource.Attributes.encryption_key != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_codeartifact_domain' encryption_key is set properly",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_codeartifact_domain' encryption_key must be set",
                "snippet": block }
} 