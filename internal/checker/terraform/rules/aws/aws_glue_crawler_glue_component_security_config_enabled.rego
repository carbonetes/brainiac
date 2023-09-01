# METADATA
# title: "Verify that the Glue component is connected to a security configuration"
# description: "To guarantee the appropriate security measures for AWS Glue components like Crawlers, Jobs, and Development Endpoints, it is imperative to establish a security configuration to enable data encryption while it is at rest."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_crawler
# custom:
#   id: CB_TFAWS_186
#   severity: HIGH
package lib.terraform.CB_TFAWS_186
supportedResources := ["aws_glue_crawler", "aws_glue_dev_endpoint", "aws_glue_job"]

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
    has_attribute(resource.Attributes, "security_configuration")
    resource.Attributes.security_configuration != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Glue component is attached to a security configuration.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Glue component must be attached to a security configuration.",
                "snippet": block }
} 