# METADATA
# title: "Verify that Cloudsearch is using https"
# description: "By using HTTPS, data transmitted between clients and Cloudsearch is encrypted, protecting it from unauthorized access and interception."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudsearch_domain#endpoint_options
# custom:
#   id: CB_TFAWS_211
#   severity: LOW
package lib.terraform.CB_TFAWS_211
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_cloudsearch_domain"
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
    block.Type == "endpoint_options"
    block.Attributes.enforce_https == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Cloudsearch is using https",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_cloudsearch_domain' endpoint_options should set 'enforce_https' true",
                "snippet": block }
} 