# METADATA
# title: "Verify that CodeBuild S3 logs are encrypted"
# description: "Verifying that CodeBuild S3 logs are encrypted enhances the security and confidentiality of build logs in AWS CodeBuild."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rgeraskin/aws3/latest/docs/resources/codebuild_project#encryption_disabled
# custom:
#   id: CB_TFAWS_294
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_294

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

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "logs_config"
    resource.Blocks[_].Blocks[_].Type == "s3_logs"
    resource.Blocks[_].Blocks[_].Attributes.encryption_disabled == true
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "CodeBuild S3 logs are encrypted.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'s3_logs' encryption_disabled must be set to false.",
                "snippet": block }
}
