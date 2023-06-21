# METADATA
# title: "Verify that S3 buckets are encrypted with KMS by default"
# description: "By enabling cross-region replication on an S3 bucket, you ensure data redundancy and fault tolerance, thereby enhancing data durability and availability in the event of regional failures or disasters."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#server_side_encryption_configuration
# custom:
#   id: CB_TFAWS_150
#   severity: LOW
package lib.terraform.CB_TFAWS_150

supportedResource := ["aws_s3_bucket", "aws_s3_bucket_server_side_encryption_configuration"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
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

pass[resource] {
	resource := input[_]
    isvalid(resource)

    server_side_encryption_configuration    := block_check(resource.Blocks[_], "server_side_encryption_configuration")
    rule                                    := block_check(server_side_encryption_configuration.Blocks[_], "rule")
    apply_server_side_encryption_by_default := block_check(rule.Blocks[_], "apply_server_side_encryption_by_default")
    
    apply_server_side_encryption_by_default.Attributes.sse_algorithm == "aws:kms"
}

block_check(block, key) := result {
    block.Type == key
    result := block
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_s3_bucket' or 'aws_s3_bucket_server_side_encryption_configuration' for 'server_side_encryption_configuration' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_s3_bucket' or 'aws_s3_bucket_server_side_encryption_configuration' for 'server_side_encryption_configuration' should be set.",
                "snippet": block }
} 