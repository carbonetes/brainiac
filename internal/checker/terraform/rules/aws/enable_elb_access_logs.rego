# METADATA
# title: "Verify that ELB has access logging enabled"
# description: "By enabling access logging for an Elastic Load Balancer (ELB), you can ensure comprehensive monitoring and analysis of incoming traffic, aiding in troubleshooting, compliance, and security investigations."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elb#access_logs
# custom:
#   id: CB_TFAWS_099
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_099

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_elb"
}

has_attribute(key, value) if {
	value in object.keys(key)
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
	has_access_logs(resource.Blocks)
}

has_access_logs(blocks) := result if {
	some block in blocks
	block.Type == "access_logs"
	result := is_enabled(block.Attributes, "enabled")
} else := result if {
	result := false
}

is_enabled(key, value) := result if {
	key[value] == true
	result := true
} else := result if {
	key[value] == false
	result := false
} else := result if {
	result := true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_elb' for 'access_logs' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_elb' for 'access_logs' should be set.",
		"snippet": block,
	}
}