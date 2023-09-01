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
    resource.Blocks[_].Attributes.enforce_https == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Cloudsearch is using https",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_cloudsearch_domain' endpoint_options should set 'enforce_https' true",
                "snippet": block }
} 