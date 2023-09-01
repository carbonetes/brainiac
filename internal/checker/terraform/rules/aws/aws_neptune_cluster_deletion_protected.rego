# METADATA
# title: "Verify AWS Neptune cluster deletion protection is enabled"
# description: "Enabling deletion protection adds an additional layer of security, preventing the deletion of Neptune clusters, which can contain valuable and sensitive data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster.html#deletion_protection
# custom:
#   id: CB_TFAWS_358
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_358

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_neptune_cluster"
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
    resource.Attributes.deletion_protection == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Neptune deletion protection is enabled.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Neptune deletion protection should be enabled.",
                "snippet": block }
}
