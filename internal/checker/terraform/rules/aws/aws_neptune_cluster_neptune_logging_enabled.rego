# METADATA
# title: "Make certain that Neptune logging is activated"
# description: "Setting your cluster up to opportunistically export its logs to AWS Cloudwatch is advised."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster
# custom:
#   id: CB_TFAWS_070
#   severity: HIGH
package lib.terraform.CB_TFAWS_070

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_neptune_cluster"
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
    attributes := resource.Attributes
    some enabled in attributes.enable_cloudwatch_logs_exports
	enabled == "audit"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := { "message": "Neptune logging is active.",
                "snippet": block}
}

failed contains result if {
	some block in fail
	result := { "message": "Neptune logging should be active",
                "snippet": block }
}