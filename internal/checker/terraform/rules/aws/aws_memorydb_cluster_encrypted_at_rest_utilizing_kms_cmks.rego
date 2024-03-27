# METADATA
# title: "Verify KMS CMKs are being used to encrypt MemoryDB at rest"
# description: "In accordance with this policy, MemoryDB that use default KMS keys rather than customer-managed keys for encryption are identified. To encrypt your MemoryDB data, it is recommended that you utilize customer-managed KMS Keys. You are granted total control on the encrypted data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/memorydb_cluster
# custom:
#   id: CB_TFAWS_192
#   severity: LOW
package lib.terraform.CB_TFAWS_192
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_memorydb_cluster"
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
    resource.Attributes.kms_key_arn != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "MemoryDB are CMK encrypted.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "MemoryDB must be CMK encrypted.",
                "snippet": block }
} 