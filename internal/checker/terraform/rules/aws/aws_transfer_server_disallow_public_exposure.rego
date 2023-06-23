# METADATA
# title: "Verify that the Transfer Server is not accessible to the public"
# description: "You may help safeguard your data from illegal access or manipulation by making sure that your Azure Transfer Server is not publicly accessible."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_server
# custom:
#   id: CB_TFAWS_154
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_154

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_transfer_server"
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
    endpointTypes := ["VPC", "VPC_ENDPOINT"]
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "endpoint_type")
    resource.Attributes.endpoint_type == endpointTypes[_]
}


fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_transfer_server' is not accessible to the public.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_workspaces_workspace' must not be accessible to the public.",
                "snippet": block }
} 