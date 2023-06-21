# METADATA
# title: "Verify that all data stored in Aurora is securely encrypted at rest"
# description: "By enabling storage encryption in Aurora, sensitive data is protected against unauthorized access, ensuring the confidentiality and integrity of the stored information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance.html#storage_encrypted
# custom:
#   id: CB_TFAWS_110
#   severity: HIGH
package lib.terraform.CB_TFAWS_110

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_rds_cluster"
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
    resource.Attributes.engine_mode == "serverless"
}

pass[resource] {
	resource := input[_]
    isvalid(resource)
    not resource.Attributes.engine_mode == "serverless"
    resource.Attributes.storage_encrypted == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_rds_cluster' for 'storage_encrypted' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_rds_cluster' for 'storage_encrypted' should be set.",
                "snippet": block }
} 