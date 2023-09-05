# METADATA
# title: "Verify that CodeBuild Project encryption is not disabled"
# description: "Enabling encryption for CodeBuild projects helps maintain the confidentiality and integrity of your build artifacts and sensitive information, providing an additional layer of security for your software development and deployment processes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project
# custom:
#   id: CB_TFAWS_086
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_086

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_codebuild_project"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "artifacts"
    block.Attributes.encryption_disabled == false
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_codebuild_project' encryption is not disabled.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_codebuild_project' encryption should not be disabled",
                "snippet": block }
}
