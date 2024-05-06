# METADATA
# title: "Verify the expected codes in IBM DNS GLB Monitor are properly configured"
# description: "This policy ensures that the 'expected_codes' attribute within the 'ibm_dns_glb_monitor' resource is one of the supported HTTP response codes when the 'type' is either HTTP or HTTPS. Using an unsupported expected code can lead to operational issues."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/dns_glb_monitor
# custom:
#   id: CB_TFIBM_116
#   severity: LOW
package lib.terraform.CB_TFIBM_116

import rego.v1

isvalid(block) if {
    block.Type == "resource"
    "ibm_dns_glb_monitor" in block.Labels
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
    hasUnsupportedExpectedCodes(resource)
}

hasUnsupportedExpectedCodes(block) if {
    supported_types := ["HTTP", "HTTPS"]
    block.Attributes.type in supported_types
    supported_codes := ["200", "201", "202", "203", "204", "205", "206", "207", "208", "226", "xx"]
    not block.Attributes.expected_codes in supported_codes
}

passed contains result if {
    some block in pass
    result := {
        "message": "The expected codes in the IBM DNS GLB Monitor resource are properly configured. No action required.",
        "snippet": block,
    }
}

failed contains result if {
    some block in fail
    result := {
        "message": "The expected codes in the IBM DNS GLB Monitor resource are not properly configured. Please ensure the 'expected_codes' is one of the supported codes: 200, 201, 202, 203, 204, 205, 206, 207, 208, 226, xx.",
        "snippet": block,
    }
}
