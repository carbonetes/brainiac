# METADATA
# title: "Verify SSM documents are not Public"
# description: "By restricting public access to SSM documents, Terraform helps maintain data security, compliance, and adherence to AWS security best practices."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/4.8.0/docs/data-sources/ssm_document
# custom:
#   id: CB_TFAWS_282
#   severity: HIGH
package lib.terraform.CB_TFAWS_282

supportedResources := ["aws_ssm_document", "aws_ssm_document_permission"]
isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "permissions"
    resource.Blocks[_].Attributes.account_ids == "All"
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.account_ids == "All"
}


pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "SSM documents are not Public.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "SSM documents account_ids permissions should not be set to 'All'.",
                "snippet": block }
}
