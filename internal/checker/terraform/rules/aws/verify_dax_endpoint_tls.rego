# METADATA
# title: "Verify that DAX cluster endpoint is using TLS"
# description: "By enabling TLS encryption for the DAX cluster endpoint, sensitive data transmitted between client applications and the DAX cluster is protected, ensuring secure and confidential communication."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dax_cluster#cluster_endpoint_encryption_type
# custom:
#   id: CB_TFAWS_228
#   severity: LOW
package lib.terraform.CB_TFAWS_228

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_dax_cluster"
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
    resource.Attributes.cluster_endpoint_encryption_type == "TLS"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "DAX cluster endpoint is using TLS",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "DAX cluster endpoint should use TLS",
                "snippet": block }
} 