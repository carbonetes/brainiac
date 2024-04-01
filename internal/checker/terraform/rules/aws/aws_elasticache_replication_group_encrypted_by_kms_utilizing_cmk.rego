# METADATA
# title: "Ensures that a customer managed Key (CMK) should be used to encrypt the Elasticache replication group"
# description: "This quick test verifies that the Elasticache replication group encrypts its contents with AWS key management - KMS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group
# custom:
#   id: CB_TFAWS_182
#   severity: LOW
package lib.terraform.CB_TFAWS_182
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_elasticache_replication_group"
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
	result := { "message": "Customer Managed Key (CMK) is used to encrypt the Elasticache replication group.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Customer Managed Key (CMK) must be used to encrypt the Elasticache replication group.",
                "snippet": block }
} 