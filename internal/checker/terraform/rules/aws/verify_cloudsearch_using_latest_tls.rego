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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudsearch_domain"
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
    resource.Blocks[_].Type == "endpoint_options"
    resource.Blocks[_].Attributes.tls_security_policy == "Policy-Min-TLS-1-2-2019-07"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_cloudsearch_domain' endpoint_options is set properly",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_cloudsearch_domain' endpoint_options 'tls_security_policy' should be set to latest",
                "snippet": block }
} 