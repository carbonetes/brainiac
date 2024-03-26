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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_workspaces_workspace"
}

has_attribute(key, value) if {
    value in object.keys(key)
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if {
    some resource in input
	isvalid(resource)
    has_attribute(resource.Attributes, "user_volume_encryption_enabled")
    resource.Attributes.user_volume_encryption_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_workspaces_workspace' user volumes is encrypted properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_workspaces_workspace' user volumes must be encrypted properly.",
                "snippet": block }
}