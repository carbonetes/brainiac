# METADATA
# title: "Guarantee the privacy of MSK nodes"
# description: "This check ensures that the nodes in Amazon Managed Streaming for Apache Kafka are configured as private to enhance the security and prevent unauthorized access to the cluster."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/msk_cluster
# custom:
#   id: CB_TFAWS_270
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_270

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_msk_cluster"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
}

passed[result] {
	block := pass[_]
	result := { "message": "MSK nodes are configured as private.",
                "snippet": block }
}

failed := []
