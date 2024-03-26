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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    supported_resources := ["aws_s3_bucket", "aws_s3_bucket_server_side_encryption_configuration"]
    label in supported_resources
}

has_attribute(key, value) if {
    value in object.keys(key)
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if {
    some resource in input
    isvalid(resource)
    some server_side_encrypt in resource.Blocks
    server_side_encryption_configuration    := block_check(server_side_encrypt, "server_side_encryption_configuration")
    some r in server_side_encrypt.Blocks
    rule                                    := block_check(r, "rule")
    some apply_server in r.Blocks
    apply_server_side_encryption_by_default := block_check(apply_server, "apply_server_side_encryption_by_default")
    apply_server_side_encryption_by_default.Attributes.sse_algorithm == "aws:kms"
}

block_check(block, key) := result if {
    block.Type == key
    result := block
} 

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_s3_bucket' or 'aws_s3_bucket_server_side_encryption_configuration' for 'server_side_encryption_configuration' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_s3_bucket' or 'aws_s3_bucket_server_side_encryption_configuration' for 'server_side_encryption_configuration' should be set.",
                "snippet": block }
} 