# METADATA
# title: "Verify Appsync API Cache is encrypted in transit"
# description: "By verifying that the AppSync API cache is encrypted in transit, this policy helps ensure the confidentiality and integrity of data exchanged between the API and the cache."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_api_cache#transit_encryption_enabled
# custom:
#   id: CB_TFAWS_201
#   severity: LOW
package lib.terraform.CB_TFAWS_201
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
    has_attribute(resource.Attributes, "transit_encryption_enabled")
    resource.Attributes.transit_encryption_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Appsync API Cache is encrypted at transit",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Appsync API Cache 'transit_encryption_enabled' should be set to true",
                "snippet": block }
} 