# METADATA
# title: "Verify the protocol in IBM DNS GLB Monitor is properly configured"
# description: "This policy ensures that the 'type' attribute within the 'ibm_dns_glb_monitor' resource is one of the supported protocols: HTTP, HTTPS, or TCP. Using an unsupported protocol can lead to operational issues."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/dns_glb_monitor
# custom:
#   id: CB_TFIBM_114
#   severity: LOW
package lib.terraform.CB_TFIBM_114

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
    hasUnsupportedProtocolType(resource)
}

hasUnsupportedProtocolType(block) if {
    supported_types := ["HTTP", "HTTPS", "TCP"]
    not block.Attributes.type in supported_types
}

passed contains result if {
    some block in pass
    result := {
        "message": "The protocol type in the IBM DNS GLB Monitor resource is properly configured. No action required.",
        "snippet": block,
    }
}

failed contains result if {
    some block in fail
    result := {
        "message": "The protocol type in the IBM DNS GLB Monitor resource is not properly configured. Please ensure the 'type' is one of the supported protocols: HTTP, HTTPS, or TCP.",
        "snippet": block,
    }
}
