# METADATA
# title: "A secure Athena Database should be encrypted at all times (the default is not encrypted)."
# description: "In order to further safeguard your data from illegal access to the underlying Amazon S3 storage, the encryption at rest capability made available for AWS Athena query results is available."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
# custom:
#   id: CB_TFAWS_059
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_059

import future.keywords.in 

supportedResource := ["aws_athena_database"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource] {
    resource := input[_]
    isvalid(resource)
    encryption_configuration := resource.Blocks[_]
    encryption_configuration.Type == "encryption_configuration"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "aws_athena_database encryption is encrypted.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "aws_athena_database encryption should be encrypted.",
                "snippet": block}
}
