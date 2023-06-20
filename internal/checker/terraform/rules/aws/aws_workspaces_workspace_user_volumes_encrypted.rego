# METADATA
# title: "Verify that the user volumes of the workspace are encrypted"
# description: "Encrypting your Workspace user volumes helps protect your data from unauthorized access or tampering. That way, you can ensure that only authorized users can access and modify the contents of your volumes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/workspaces_workspace.html
# custom:
#   id: CB_TFAWS_136
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_136

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
    has_attribute(resource.Attributes, "user_volume_encryption_enabled")
    resource.Attributes.user_volume_encryption_enabled == true
}


fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_workspaces_workspace' user volumes is encrypted properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_workspaces_workspace' user volumes must be encrypted properly.",
                "snippet": block }
} 