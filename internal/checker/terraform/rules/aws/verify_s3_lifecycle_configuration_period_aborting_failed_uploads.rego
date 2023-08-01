# METADATA
# title: "Verify S3 lifecycle configuration sets period for aborting failed uploads"
# description: "Verifying the S3 lifecycle configuration to set a period for aborting failed uploads ensures cost optimization, resource management, performance improvement, data integrity, security compliance, and automation benefits in your AWS S3 storage infrastructure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.1.0/docs/data-sources/s3_bucket
# custom:
#   id: CB_TFAWS_275
#   severity: LOW
package lib.terraform.CB_TFAWS_275

import future.keywords.in 

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_s3_bucket_lifecycle_configuration"
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
    block.Type == "rule"
    block.Blocks[_].Type == "abort_incomplete_multipart_upload"
}


fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "S3 lifecycle configuration sets period for aborting failed uploads",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "S3 lifecycle configuration must set period for aborting failed uploads",
                "snippet": block }
}
