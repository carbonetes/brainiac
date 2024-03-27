# METADATA
# title: "Verify that Backup Vault is encrypted at rest using KMS CMK"
# description: "By encrypting the Backup Vault at rest using a KMS CMK, sensitive data stored in the vault remains secure and protected, ensuring compliance with data privacy regulations and mitigating the risk of unauthorized access or data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault#kms_key_arn
# custom:
#   id: CB_TFAWS_157
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_157
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_backup_vault"
}

has_attribute(key, value) if {
    value in object.keys(key)
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if {
    some resource in input
    isvalid(resource)
    has_attribute(resource.Attributes, "kms_key_arn")
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_backup_vault' for 'kms_key_arn' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_backup_vault' for 'kms_key_arn' should be set.",
                "snippet": block }
} 