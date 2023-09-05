# METADATA
# title: "Verify S3 bucket has block public ACLS enabled"
# description: "This feature helps to prevent public access to the bucket and its objects via Access Control Lists (ACLs)."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
# custom:
#   id: CB_TFAWS_050
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_050

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_s3_bucket_public_access_block"
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
    resource.Attributes.block_public_acls == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_s3_bucket_public_access_block' 'block_public_acls' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_s3_bucket_public_access_block' 'block_public_acls' should be set to true",
                "snippet": block }
} 