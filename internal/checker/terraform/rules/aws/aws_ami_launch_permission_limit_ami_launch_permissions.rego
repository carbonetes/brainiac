# METADATA
# title: "Ensures that AMI launch permissions should be restricted"
# description: "It is advised against enabling the launch of AMIs across many accounts, and if it is, make sure it is used appropriately."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami_launch_permission.html
# custom:
#   id: CB_TFAWS_204
#   severity: LOW
package lib.terraform.CB_TFAWS_204
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_ami_launch_permission"
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
    resource.Attributes.account_id != ""
    resource.Attributes.image_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "AMI launch permissions are restricted.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "AMI launch permissions are not restricted.",
                "snippet": block }
}
