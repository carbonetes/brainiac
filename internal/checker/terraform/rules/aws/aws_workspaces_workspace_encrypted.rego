# METADATA
# title: "Verify that the root volumes of the workspace are encrypted"
# description: "Your data is more secure when your Workspace root volumes are encrypted against unauthorized entry or manipulation. You can make sure that only authorized people may access and change the data on your volumes in this manner."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/workspaces_workspace.html
# custom:
#   id: CB_TFAWS_135
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_135

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_workspaces_workspace"
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
    has_attribute(resource.Attributes, "root_volume_encryption_enabled")
    resource.Attributes.root_volume_encryption_enabled == true
}


fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_workspaces_workspace' is encrypted properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_workspaces_workspace' must be encrypted properly.",
                "snippet": block }
} 