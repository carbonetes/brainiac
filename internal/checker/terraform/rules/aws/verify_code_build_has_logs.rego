# METADATA
# title: "Verify that CodeBuild project environments have a logging configuration"
# description: "By enabling comprehensive logging configurations for AWS CodeBuild projects, developers can gain valuable insights into build processes, identify potential issues, and monitor build performance efficiently, facilitating better troubleshooting and continuous improvement in the software development lifecycle."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project
# custom:
#   id: CB_TFAWS_301
#   severity: LOW
package lib.terraform.CB_TFAWS_301

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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "logs_config"
    resource.Blocks[_].Blocks[_].Type == "cloudwatch_logs"
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "logs_config"
    resource.Blocks[_].Blocks[_].Type == "s3_logs"
}

fail[resource] {
    resource := input[_]
    isvalid(resource)
    not pass[resource]
}

passed[result] {
	block := pass[_]
	result := { "message": "CodeBuild project environments have a logging configuration.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "CodeBuild project environments must have a logging configuration.",
                "snippet": block }
} 