# METADATA
# title: "Verify that DocDB TLS is not disabled"
# description: "By ensuring that DocDB TLS is not disabled, you enhance the security and protection of sensitive data transmitted between client applications and the Amazon DocumentDB cluster, guarding against potential unauthorized access and data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_parameter_group#parameter
# custom:
#   id: CB_TFAWS_097
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_097

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_docdb_cluster_parameter_group"
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

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

fail[resource] {
	resource := input[_]
    isvalid(resource)
    resource.Blocks[_].Type == "parameter"
    has_attribute(resource.Blocks[_].Attributes, "name")
    resource.Blocks[_].Attributes.name == "tls"
    has_attribute(resource.Blocks[_].Attributes, "value")
    resource.Blocks[_].Attributes.value == "disabled"
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_docdb_cluster_parameter_group' for 'parameter' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_docdb_cluster_parameter_group' for 'parameter' should be set.",
                "snippet": block }
} 