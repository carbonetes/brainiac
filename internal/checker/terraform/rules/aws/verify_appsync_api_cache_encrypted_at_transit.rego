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
    has_attribute(resource.Attributes, "transit_encryption_enabled")
    resource.Attributes.transit_encryption_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Appsync API Cache is encrypted at transit",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Appsync API Cache 'transit_encryption_enabled' should be set to true",
                "snippet": block }
} 