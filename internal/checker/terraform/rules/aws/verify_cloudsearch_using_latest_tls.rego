# METADATA
# title: "Verify that Cloudsearch is using latest TLS"
# description: "This helps protect sensitive data, prevent unauthorized access, and mitigate the risk of data breaches or unauthorized interceptions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudsearch_domain#endpoint_options
# custom:
#   id: CB_TFAWS_208
#   severity: LOW
package lib.terraform.CB_TFAWS_208
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
    block.Attributes.tls_security_policy == "Policy-Min-TLS-1-2-2019-07"
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_cloudsearch_domain' endpoint_options is set properly",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_cloudsearch_domain' endpoint_options 'tls_security_policy' should be set to latest",
                "snippet": block }
} 