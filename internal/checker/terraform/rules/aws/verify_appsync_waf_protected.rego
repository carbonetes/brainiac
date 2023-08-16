# METADATA
# title: "Verify AppSync is protected by WAF"
# description: "This measure prevents unauthorized access and helps maintain the integrity of data and resources within the AppSync APIs."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_graphql_api.html
# custom:
#   id: CB_TFAWS_335
#   severity: HIGH
package lib.terraform.CB_TFAWS_335

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_appsync_graphql_api"
}

getAppsyncLabel[label]{
    resource := input[_]
	resource.Type == "resource"
    resource.Labels[_] == "aws_appsync_graphql_api"
    label := concat(".", resource.Labels)
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

isAttachementValid{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_wafv2_web_acl_association"
    contains(resource.Attributes.resource_arn, getAppsyncLabel[_])
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    isAttachementValid
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "AppSync is protected by WAF.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "AppSync should be protected by WAF.",
                "snippet": block }
} 