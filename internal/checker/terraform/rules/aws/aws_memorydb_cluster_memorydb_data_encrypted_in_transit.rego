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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_memorydb_cluster"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.tls_enabled == false
}

passed[result] {
	block := pass[_]
	result := { "message": "AWS MemoryDB has in-transit data encryption enabled.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "AWS MemoryDB must have in-transit data encryption enabled.",
                "snippet": block }
}
