# METADATA
# title: "Verify that Redshift cluster is encrypted by KMS"
# description: "By encrypting an Amazon Redshift cluster with AWS KMS, sensitive data stored within the cluster is protected, ensuring the confidentiality and integrity of the information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster#kms_key_id
# custom:
#   id: CB_TFAWS_145
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_145
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_redshift_cluster"
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
	result := { "message": "'aws_redshift_cluster' for 'kms_key_id' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_redshift_cluster' for 'kms_key_id' should be set.",
                "snippet": block }
} 