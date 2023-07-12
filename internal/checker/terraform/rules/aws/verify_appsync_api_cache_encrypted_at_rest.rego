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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_appsync_api_cache"
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
    has_attribute(resource.Attributes, "at_rest_encryption_enabled")
    resource.Attributes.at_rest_encryption_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Appsync API Cache is encrypted at rest",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Appsync API Cache 'at_rest_encryption_enabled' should be set to true",
                "snippet": block }
} 