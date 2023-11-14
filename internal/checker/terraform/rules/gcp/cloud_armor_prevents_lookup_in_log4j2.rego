# METADATA
# title: "Verify Cloud Armor prevents message lookup in Log4j2. See CVE-2021-44228 aka log4jshell"
# description: "This ensures that Cloud Armor configurations are in place to mitigate the risk associated with the Log4j2 vulnerability (CVE-2021-44228), commonly known as log4jshell, by preventing unauthorized message lookup attacks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_security_policy
# custom:
#   id: CB_TFGCP_064
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_064
import future.keywords.in
import future.keywords.if

isvalid(block){
	block.Type == "resource"
    "google_compute_security_policy" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
    some block in input
	isvalid(block)
	some first_block in block.Blocks
	first_block.Type == "rule"
	not invalid_rule(first_block)
	some second_block in first_block.Blocks
	second_block.Type == "match"
	some third_block in second_block.Blocks
	third_block.Type == "expr"
	third_block.Attributes.expression == "evaluatePreconfiguredExpr('cve-canary')"
}

invalid_rule(block) := true if {
	block.Attributes.action == "allow"
} else := true if {
	block.Attributes.preview == true
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Cloud Armor prevents message lookup in Log4j2. See CVE-2021-44228 aka log4jshell.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Cloud Armor should prevents message lookup in Log4j2. See CVE-2021-44228 aka log4jshell.",
                "snippet": block }
}