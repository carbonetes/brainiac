# METADATA
# title: "Verify replicated backups are encrypted at rest using KMS CMKs"
# description: "By encrypting replicated backups at rest using KMS CMKs, sensitive data remains secure and protected from unauthorized access, ensuring compliance with data security standards and safeguarding against potential data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#storage_encrypted
# custom:
#   id: CB_TFAWS_274
#   severity: HIGH
package lib.terraform.CB_TFAWS_274

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_db_instance_automated_backups_replication"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.kms_key_id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Replicated backups are encrypted at rest using KMS CMKs.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Replicated backups is not encrypted at rest using KMS CMKs.",
                "snippet": block }
} 