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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_backup_vault"
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

    has_attribute(resource.Attributes, "kms_key_arn")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_backup_vault' for 'kms_key_arn' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_backup_vault' for 'kms_key_arn' should be set.",
                "snippet": block }
} 