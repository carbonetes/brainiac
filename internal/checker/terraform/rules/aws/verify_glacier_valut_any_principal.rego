# METADATA
# title: "Verify that Glacier Vault access policy is not public by only allowing specific services or principals to access it"
# description: "By implementing a restricted access policy for the Glacier Vault, only allowing specific services or principals to access it, we ensure that sensitive data stored within the vault remains secure and protected from unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault
# custom:
#   id: CB_TFAWS_158
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_158
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_glacier_vault"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

fail contains resource if {
	some resource in input
    isvalid(resource)
    access_policy := json.unmarshal(resource.Attributes.access_policy).Statement[_]
    access_policy.Principal == "*"
    access_policy.Effect == "Allow"
}

pass contains block if {
    some block in input
	isvalid(block)
   	not fail[block]
}


passed contains result if {
    some block in pass
	result := { "message": "'aws_glacier_vault' for 'access_policy' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_glacier_vault' for 'access_policy' should be set.",
                "snippet": block }
} 