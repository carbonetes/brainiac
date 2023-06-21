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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_db_cluster_snapshot"
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

    resource.Attributes.storage_encrypted == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_db_cluster_snapshot' for 'storage_encrypted' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_db_cluster_snapshot' for 'storage_encrypted' should be set.",
                "snippet": block }
} 