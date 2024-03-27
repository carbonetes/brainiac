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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_transfer_server"
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
    endpoint_types := ["VPC", "VPC_ENDPOINT"]
    some resource in input
	isvalid(resource)
    has_attribute(resource.Attributes, "endpoint_type")
    resource.Attributes.endpoint_type in endpoint_types
}


fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_transfer_server' is not accessible to the public.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_workspaces_workspace' must not be accessible to the public.",
                "snippet": block }
} 