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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    supported_resources := ["aws_s3_bucket", "aws_s3_bucket_replication_configuration"]
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
    resource.Blocks[_].Type == "replication_configuration"
    resource.Blocks[_].Blocks[_].Type == "rules"
    resource.Blocks[_].Blocks[_].Attributes.status == "Enabled"
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_s3_bucket' for 'replication_configuration' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_s3_bucket' for 'replication_configuration' should be set.",
                "snippet": block }
} 