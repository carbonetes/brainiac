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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    supported_resource := ["aws_waf_web_acl","aws_wafregional_web_acl"]
    label in supported_resource
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
    some block in resource.Blocks
    contains(block.Type, "logging_configuration")
    has_attribute(block.Attributes, "log_destination")
    block.Attributes.log_destination != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "WAF Web Access Control Lists are configured with logging enabled.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "WAF Web Access Control Lists must be configured with logging enabled.",
                "snippet": block }
} 