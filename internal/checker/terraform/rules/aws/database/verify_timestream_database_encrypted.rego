# METADATA
# title: "Verify that Timestream database is encrypted with KMS CMK"
# description: "By encrypting the Timestream database with a KMS CMK, data at rest is safeguarded against unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/timestreamwrite_database
# custom:
#   id: CB_TFAWS_138
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_138
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_timestreamwrite_database"
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
    has_attribute(resource.Attributes, "kms_key_id")
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_timestreamwrite_database' encryption is set properly.",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_timestreamwrite_database' should be ecnrypted.",
                "snippet": block }
}
