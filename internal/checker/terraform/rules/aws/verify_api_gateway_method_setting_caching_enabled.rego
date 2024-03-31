# METADATA
# title: "Verify API Gateway method setting caching is enabled"
# description: "Enabling caching for API Gateway method settings provides several benefits. It helps improve the performance and scalability of your APIs by reducing the load on backend systems."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_settings
# custom:
#   id: CB_TFAWS_224
#   severity: LOW
package lib.terraform.CB_TFAWS_224
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_api_gateway_method_settings"
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
    block.Type == "settings"
    block.Attributes.caching_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "API Gateway method setting caching is enable",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_api_gateway_method_settings' settings 'caching_enabled' should be set to latest",
                "snippet": block }
} 