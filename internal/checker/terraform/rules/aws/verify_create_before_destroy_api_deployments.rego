# METADATA
# title: "Verify Create before destroy for API deployments"
# description: "By verifying Create before destroy, you can avoid service interruptions, prevent data loss, and maintain a consistent user experience."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment
# custom:
#   id: CB_TFAWS_207
#   severity: LOW
package lib.terraform.CB_TFAWS_207
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_api_gateway_deployment"
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
    some block in resource.Blocks
    block.Type == "lifecycle"
    block.Attributes.create_before_destroy == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_api_gateway_deployment' lifecycle is set properly",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_api_gateway_deployment' lifecycle 'create_before_destroy' should be set to true",
                "snippet": block }
} 