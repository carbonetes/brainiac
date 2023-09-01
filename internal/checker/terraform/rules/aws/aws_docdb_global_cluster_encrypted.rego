# METADATA
# title: "Verify that the DocDB Global Cluster enforces encryption at rest, as the default state is unencrypted"
# description: "This checks whether encryption at rest is enabled for the DocDB Global Cluster. It ensures that data in the cluster is securely encrypted, providing an additional layer of protection for sensitive information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_global_cluster
# custom:
#   id: CB_TFAWS_269
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_269

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_docdb_global_cluster"
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
    has_attribute(resource.Attributes, "storage_encrypted")
    resource.Attributes.storage_encrypted == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Encryption at rest is activated for the DocDB Global Cluster.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Encryption at rest must be activated for the DocDB Global Cluster.",
                "snippet": block }
} 