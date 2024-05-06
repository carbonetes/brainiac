# METADATA
# title: "Verify CloudTrail logging is enabled"
# description: "By enabling CloudTrail logging, you gain visibility into actions taken on your resources, including who performed the action, when it occurred, and what resources were affected."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail#enable_logging
# custom:
#   id: CB_TFAWS_230
#   severity: LOW
package lib.terraform.CB_TFAWS_230
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_cloudtrail"
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
    resource.Attributes.enable_logging == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_cloudtrail' 'enable_logging' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_cloudtrail' 'enable_logging' should be set to true.",
                "snippet": block }
} 