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

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_msk_cluster"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "logging_info"
	some logblock in block.Blocks
	logblock.Type == "broker_logs"
	some logtypeblock in logblock.Blocks
	supportedlogtypes := ["cloudwatch_logs", "firehose", "s3"]
	logtypeblock.Type in supportedlogtypes
	logtypeblock.Attributes.enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_msk_cluster' logging enabled",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_msk_cluster' logging enabled should be true",
		"snippet": block,
	}
}