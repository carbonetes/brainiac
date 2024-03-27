# METADATA
# title: "Verify that EC2 is EBS optimized"
# description: "By enabling EBS optimization for EC2 instances, the performance of EBS storage volumes can be significantly enhanced, resulting in improved I/O throughput and reduced latency for applications with high disk I/O requirements."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#ebs_optimized
# custom:
#   id: CB_TFAWS_121
#   severity: LOW
package lib.terraform.CB_TFAWS_121

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_instance"
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
	resource.Attributes.ebs_optimized == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_instance' for 'ebs_optimized' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_instance' for 'ebs_optimized' should be set.",
		"snippet": block,
	}
}