# METADATA
# title: "Verify that the App Flow connector profile utilizes CMK"
# description: "Database snapshots that hadn't been KMS-encrypted are identified by this policy. For all storage volumes and snapshots, managing your own encryption keys is recommended."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_snapshot_copy
# custom:
#   id: CB_TFAWS_241
#   severity: LOW
package lib.terraform.CB_TFAWS_241
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_db_snapshot_copy"
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
    has_attribute(resource.Attributes, "kms_key_id")
    resource.Attributes.kms_key_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "App Flow connector profile utilizes CMK.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "App Flow connector profile must be utilizing CMK.",
                "snippet": block }
} 