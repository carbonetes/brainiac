# METADATA
# title: "Make certain that CodeBuild projects are CMK-encrypted"
# description: "Your data is more secure from illegal access or manipulation when your CodeBuild projects are encrypted. By doing this, you can make sure that only people with the proper permissions can view and change the contents of your projects."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rgeraskin/aws3/latest/docs/resources/codebuild_project
# custom:
#   id: CB_TFAWS_122
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_122

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_codebuild_project"
}

has_attribute(key, value){
    _ = key[value]
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
    has_attribute(resource.Attributes, "encryption_key")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_codebuild_project' is encrypted.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_codebuild_project' should be encrypted.",
                "snippet": block }
}
