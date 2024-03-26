# METADATA
# title: "Verify that RDS database cluster snapshot is encrypted"
# description: "By encrypting the RDS database cluster snapshot, sensitive data is safeguarded, ensuring the confidentiality and security of the snapshot, even in the event of unauthorized access or data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/db_cluster_snapshot#storage_encrypted
# custom:
#   id: CB_TFAWS_151
#   severity: LOW
package lib.terraform.CB_TFAWS_151
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_db_cluster_snapshot"
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
    resource.Attributes.storage_encrypted == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_db_cluster_snapshot' for 'storage_encrypted' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_db_cluster_snapshot' for 'storage_encrypted' should be set.",
                "snippet": block }
} 