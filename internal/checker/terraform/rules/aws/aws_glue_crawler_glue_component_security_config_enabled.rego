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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    supported_resources := ["aws_glue_crawler", "aws_glue_dev_endpoint", "aws_glue_job"]
    some label in block.Labels 
    label in supported_resources
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
    has_attribute(resource.Attributes, "security_configuration")
    resource.Attributes.security_configuration != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Glue component is attached to a security configuration.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Glue component must be attached to a security configuration.",
                "snippet": block }
} 