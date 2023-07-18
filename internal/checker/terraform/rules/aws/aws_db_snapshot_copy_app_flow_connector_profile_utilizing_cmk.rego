# METADATA
# title: "Verify that the App Flow connector profile utilizes CMK."
# description: "Database snapshots that hadn't been KMS-encrypted are identified by this policy. For all storage volumes and snapshots, managing your own encryption keys is recommended."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_snapshot_copy
# custom:
#   id: CB_TFAWS_241
#   severity: LOW
package lib.terraform.CB_TFAWS_241

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_db_snapshot_copy"
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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "kms_key_id")
    resource.Attributes.kms_key_id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "App Flow connector profile utilizes CMK.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "App Flow connector profile must be utilizing CMK.",
                "snippet": block }
} 