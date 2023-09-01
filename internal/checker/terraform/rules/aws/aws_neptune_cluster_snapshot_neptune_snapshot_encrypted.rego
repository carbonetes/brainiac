# METADATA
# title: "Verify that the encryption of Neptune snapshots is robust and secure"
# description: "Enforce robust encryption measures for Neptune snapshots to safeguard sensitive data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster_snapshot.html
# custom:
#   id: CB_TFAWS_261
#   severity: HIGH
package lib.terraform.CB_TFAWS_261

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_neptune_cluster_snapshot"
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
	result := { "message": "Neptune snapshots is encrypted in a way that meets security standards.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Neptune snapshots must be encrypted in a way that meets security standards.",
                "snippet": block }
} 