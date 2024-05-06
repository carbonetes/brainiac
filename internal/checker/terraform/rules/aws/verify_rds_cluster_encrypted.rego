# METADATA
# title: "Verify that RDS global clusters are encrypted"
# description: "By enabling storage encryption on the RDS global cluster, sensitive data is protected at rest, ensuring the confidentiality and security of the database, and mitigating the risk of unauthorized access or data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_global_cluster#storage_encrypted
# custom:
#   id: CB_TFAWS_143
#   severity: LOW
package lib.terraform.CB_TFAWS_143
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_rds_global_cluster"
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
	result := { "message": "'aws_rds_global_cluster' for 'storage_encrypted' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_rds_global_cluster' for 'storage_encrypted' should be set.",
                "snippet": block }
} 