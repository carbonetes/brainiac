# METADATA
# title: "Verify that CodeBuild project environments do not have privileged mode enabled"
# description: "By disabling privileged mode in CodeBuild project environments, we ensure that the build process operates within a more secure and controlled context, reducing the risk of unauthorized access or malicious activities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project
# custom:
#   id: CB_TFAWS_302
#   severity: LOW
package lib.terraform.CB_TFAWS_302

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_codebuild_project"
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

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "environment"
    resource.Blocks[_].Attributes.privileged_mode == true
}

pass[resource] {
    resource := input[_]
    isvalid(resource)
    not fail[resource]
}

passed[result] {
	block := pass[_]
	result := { "message": "CodeBuild project environments do not have privileged mode enabled.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "CodeBuild project environments must not have privileged mode enabled.",
                "snippet": block }
} 