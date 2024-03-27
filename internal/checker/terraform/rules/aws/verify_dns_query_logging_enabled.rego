# METADATA
# title: "Verify Domain Name System (DNS) query logging is enabled for Amazon Route 53 hosted zones"
# description: "Enabling query logging enhances your monitoring and security capabilities by capturing DNS queries and responses, aiding in troubleshooting, detecting malicious activities, and providing insights into your DNS traffic."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone.html
# custom:
#   id: CB_TFAWS_349
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_349

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_route53_zone"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getroutezonelabel contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_route53_zone" in resource.Labels
	label := concat(".", resource.Labels)
}

is_route_query_log_valid if {
	some resource in input
	resource.Type == "resource"
	"aws_route53_query_log" in resource.Labels
	some label in getroutezonelabel
	contains(resource.Attributes.zone_id, label)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_route_query_log_valid
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Domain Name System (DNS) query logging is enabled for Amazon Route 53 hosted zones.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Domain Name System (DNS) query logging should be enable for Amazon Route 53 hosted zones.",
		"snippet": block,
	}
}
