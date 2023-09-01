# METADATA
# title: "Verify MSK Cluster logging is enabled"
# description: "Enabling logging for your MSK cluster allows you to capture important logs and diagnostic information related to the cluster's operation, performance, and error conditions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster.html#logging_info
# custom:
#   id: CB_TFAWS_091
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_091

import future.keywords.in 

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_msk_cluster"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "logging_info"
    logBlock := block.Blocks[_]
    logBlock.Type == "broker_logs"
    logTypeBlock := logBlock.Blocks[_]
    supportedLogTypes := ["cloudwatch_logs", "firehose", "s3"]
    logTypeBlock.Type == supportedLogTypes[_]
    logTypeBlock.Attributes.enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_msk_cluster' logging enabled",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_msk_cluster' logging enabled should be true",
                "snippet": block }
}
