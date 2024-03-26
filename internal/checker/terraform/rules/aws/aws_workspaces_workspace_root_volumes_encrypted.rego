# METADATA
# title: "Make sure that the root volumes of the workspace are encrypted"
# description: "Your data is more secure when your Workspace root volumes are encrypted against unauthorized entry or manipulation. You can make sure that only authorized people may access and change the data on your volumes in this manner."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/workspaces_workspace.html
# custom:
#   id: CB_TFAWS_135
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_135
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
    has_attribute(resource.Attributes, "root_volume_encryption_enabled")
    resource.Attributes.root_volume_encryption_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := { "message": "'aws_workspaces_workspace' root volumes is encrypted properly.",
                "snippet": block }
}

failed contains result if {
	some block in fail
	result := { "message": "'aws_workspaces_workspace' root volumes must be encrypted properly.",
                "snippet": block }
} 