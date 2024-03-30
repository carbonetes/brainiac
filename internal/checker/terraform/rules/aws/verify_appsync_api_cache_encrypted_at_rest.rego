# METADATA
# title: "Verify Appsync API Cache is encrypted at rest"
# description: "By verifying that the cache is encrypted at rest, this policy helps to safeguard sensitive data stored in the cache, such as user credentials, personal information, or any other sensitive data used by your applications."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_api_cache
# custom:
#   id: CB_TFAWS_200
#   severity: LOW
package lib.terraform.CB_TFAWS_200
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_appsync_api_cache"
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
    has_attribute(resource.Attributes, "at_rest_encryption_enabled")
    resource.Attributes.at_rest_encryption_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Appsync API Cache is encrypted at rest",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Appsync API Cache 'at_rest_encryption_enabled' should be set to true",
                "snippet": block }
} 