# METADATA
# title: "Verify that S3 bucket has cross-region replication enabled"
# description: "By enabling cross-region replication on an S3 bucket, you ensure data redundancy and fault tolerance, thereby enhancing data durability and availability in the event of regional failures or disasters."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#replication_configuration
# custom:
#   id: CB_TFAWS_149
#   severity: LOW
package lib.terraform.CB_TFAWS_149

supportedResource := ["aws_s3_bucket", "aws_s3_bucket_replication_configuration"]

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
    resource.Blocks[_].Type == "replication_configuration"
    resource.Blocks[_].Blocks[_].Type == "rules"
    resource.Blocks[_].Blocks[_].Attributes.status == "Enabled"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_s3_bucket' for 'replication_configuration' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_s3_bucket' for 'replication_configuration' should be set.",
                "snippet": block }
} 