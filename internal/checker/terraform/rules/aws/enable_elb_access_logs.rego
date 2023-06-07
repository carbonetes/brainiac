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

import future.keywords.if

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_elb"
}

has_attribute(key, value) {
  _ = key[value]
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
    has_access_logs(resource.Blocks)
}

has_access_logs(blocks) := result if {
    blocks[_].Type == "access_logs"
    result := is_enabled(blocks[_].Attributes, "enabled")
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

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_elb' for 'access_logs' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_elb' for 'access_logs' should be set.",
                "snippet": block }
} 