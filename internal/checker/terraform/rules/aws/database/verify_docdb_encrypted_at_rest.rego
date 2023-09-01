# METADATA
# title: "Verify DocDB is encrypted at rest (default is unencrypted)"
# description: "nabling encryption at rest for Amazon DocumentDB (DocDB) provides an added layer of security for your data. By default, DocDB does not encrypt data at rest, which can pose a risk if sensitive or confidential information is stored in the database."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster
# custom:
#   id: CB_TFAWS_083
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_083

import future.keywords.in 

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_docdb_cluster"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.storage_encrypted == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_docdb_cluster' 'storage_encrypted' is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_docdb_cluster' 'storage_encrypted' should be set to true.",
                "snippet": block }
}
