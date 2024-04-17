# METADATA
# title: "Verify that the guid is not hardcoded"
# description: "This policy validates that the 'guid' attribute is not hardcoded in the 'ibm_app_config_segment' resource. Hardcoding 'guid' can lead to potential security risks as sensitive data might be exposed."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/app_config_segment
# custom:
#   id: CB_TFIBM_040
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_040

import rego.v1

isvalid(block) if {
    block.Type == "resource"
    "ibm_app_config_segment" in block.Labels
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
    hasNoHardcodedSensitiveAttributes(resource)
}

hasNoHardcodedSensitiveAttributes(block) if {
    regex.match(`\b[A-Fa-f0-9]{8}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{12}\b`, block.Attributes.guid)
}

passed contains result if {
    some block in pass
    result := {
        "message": "IBM App Config Segment resource does not have a hardcoded 'guid', minimizing potential security risks.",
        "snippet": block,
    }
}

failed contains result if {
    some block in fail
    result := {
        "message": "IBM App Config Segment resource has a hardcoded 'guid', leading to potential security risks due to sensitive data exposure.",
        "snippet": block,
    }
}