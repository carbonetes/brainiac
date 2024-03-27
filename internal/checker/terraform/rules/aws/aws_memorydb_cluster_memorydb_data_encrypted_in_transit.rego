# METADATA
# title: "Verify that MemoryDB data is encrypted while in transit"
# description: "This policy identifies the AWS MemoryDB that are configured with disabled in-transit data encryption. It is recommended that these resources will be configured with in-transit data encryption to minimize risk for sensitive data being leaked."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/memorydb_cluster
# custom:
#   id: CB_TFAWS_193
#   severity: LOW
package lib.terraform.CB_TFAWS_193
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_memorydb_cluster"
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
    resource.Attributes.tls_enabled == false
}

pass contains block if {
    some block in input
	isvalid(block)
   	not fail[block]
}

passed contains result if {
    some block in pass
	result := { "message": "AWS MemoryDB has in-transit data encryption enabled.",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "AWS MemoryDB must have in-transit data encryption enabled.",
                "snippet": block }
}
