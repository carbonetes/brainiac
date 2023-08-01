# METADATA
# title: "Verify RDS Cluster activity streams are encrypted using KMS CMKs."
# description: "By enabling KMS key for RDS encryption, the Terraform configuration ensures that the RDS cluster stays up-to-date with the latest enhancements and security patches, maintaining data integrity and minimizing vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_activity_stream
# custom:
#   id: CB_TFAWS_276
#   severity: LOW
package lib.terraform.CB_TFAWS_276

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_rds_cluster_activity_stream"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.kms_key_id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "RDS Cluster activity streams are encrypted using KMS CMKs.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "RDS Cluster activity streams is not encrypted using KMS CMKs.",
                "snippet": block }
} 