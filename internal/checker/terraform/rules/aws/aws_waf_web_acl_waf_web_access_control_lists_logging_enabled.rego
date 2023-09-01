# METADATA
# title: "Verify WAF Web Access Control Lists are configured with logging enabled"
# description: "You must enable logging in order to obtain comprehensive information about the web traffic your Web Access Control Lists (Web ACLs) evaluated."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/4.3.0/docs/data-sources/waf_web_acl
# custom:
#   id: CB_TFAWS_167
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_167

supportedResources := ["aws_waf_web_acl","aws_wafregional_web_acl"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
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
    contains(resource.Blocks[_].Type, "logging_configuration")
    has_attribute(resource.Blocks[_].Attributes, "log_destination")
    resource.Blocks[_].Attributes.log_destination != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "WAF Web Access Control Lists are configured with logging enabled.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "WAF Web Access Control Lists must be configured with logging enabled.",
                "snippet": block }
} 