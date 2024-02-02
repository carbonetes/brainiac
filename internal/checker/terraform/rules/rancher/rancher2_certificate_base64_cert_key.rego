# METADATA
# title: "Verify Proper Base64 Certificate and Key Configuration in Rancher Certificate"
# description: "This policy ensures that the Rancher Certificate configuration includes valid base64-encoded values for the certs and key attributes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/certificate
# custom:
#   id: CB_TFRAN_046
#   severity: HIGH
package lib.terraform.CB_TFRAN_046

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_certificate" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

is_valid_base64(s) {
	base64.encode(base64.decode(s)) == s
}

pass[block] {
	some block in input
	isvalid(block)
	is_valid_base64(block.Attributes.certs) 
}

pass[block] {
	some block in input
	isvalid(block)
	is_valid_base64(block.Attributes.key) 
}
fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Certificate configuration includes valid base64-encoded values for certs and key attributes.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Certificate configuration has invalid or missing values for certs and/or key attributes. Ensure certs and key are properly base64-encoded.",
        "snippet": block,
    }
}