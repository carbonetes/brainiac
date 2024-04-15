# METADATA
# title: "Verify that the guid is not hardcoded"
# description: "This policy validates that the 'guid' attribute is not hardcoded in the 'ibm_app_config_collection' resource. Hardcoding 'guid' can lead to potential security risks as sensitive data might be exposed."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/app_config_collection
# custom:
#   id: CB_TFIBM_026
#   severity: HIGH
package lib.terraform.CB_TFIBM_026

import rego.v1

isvalid(block) if {
    block.Type == "resource"
    some label in block.Labels
    supported_resources := ["ibm_app_config_collection", "ibm_app_config_collections"]
    label in supported_resources
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
        "message": "IBM App Config Collection resource does not have a hardcoded 'guid', minimizing potential security risks.",
        "snippet": block,
    }
}

failed contains result if {
    some block in fail
    result := {
        "message": "IBM App Config Collection resource has a hardcoded 'guid', leading to potential security risks due to sensitive data exposure.",
        "snippet": block,
    }
}