# METADATA
# title: "Verify all redirect URLs are HTTPS"
# description: "This policy ensures that all URLs specified in the 'ibm_appid_redirect_urls' resource are using the HTTPS protocol. Redirecting users to non-HTTPS URLs can pose security risks, hence it's critical to enforce HTTPS for all redirect URLs."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/appid_redirect_urls
# custom:
#   id: CB_TFIBM_068
#   severity: HIGH
package lib.terraform.CB_TFIBM_068

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	"ibm_appid_redirect_urls" in block.Labels
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
	not fail[resource]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	hasNonHttpsUrl(resource)
}

hasNonHttpsUrl(block) if {
	some url in block.Attributes.urls
	not startswith(url, "https://")
}

passed contains result if {
    some block in pass
    result := {
        "message": "All redirect URLs in the IBM APPID resource are secure (HTTPS).",
        "snippet": block,
    }
}

failed contains result if {
    some block in fail
    result := {
        "message": "One or more redirect URLs in the IBM APPID resource are not secure (non-HTTPS).",
        "snippet": block,
    }
}