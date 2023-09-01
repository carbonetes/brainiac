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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_rds_global_cluster"
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
	result := { "message": "'aws_rds_global_cluster' for 'storage_encrypted' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_rds_global_cluster' for 'storage_encrypted' should be set.",
                "snippet": block }
} 