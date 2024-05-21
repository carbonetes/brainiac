# METADATA
# title: "Verify that only proper image references are used"
# description: "This policy ensures that only image references originating from trusted namespaces are permitted, mitigating the risk of insecure image deployments."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/code_engine_app
# custom:
#   id: CB_TFIBM_099
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_099
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
    label == "ibm_code_engine_app"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains block if {
    some block in input
    isvalid(block)
    not pass[block]
}

pass contains resource if {
	some resource in input
	isvalid(resource)
    attributes := resource.Attributes
    "image_reference" in object.keys(attributes)
    img_ref := attributes.image_reference
    pattern := `^([a-z0-9][a-z0-9\\-_.]+[a-z0-9][\/])?([a-z0-9][a-z0-9\\-_]+[a-z0-9][\/])?[a-z0-9][a-z0-9\\-_.\/]+[a-z0-9](:[\\w][\\w.\\-]{0,127})?(@sha256:[a-fA-F0-9]{64})?$`
    regex.match(pattern, img_ref)
}

passed contains result if {
	some block in pass
	result := {
		"message": "Proper image reference is used.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Proper image reference is not used.",
		"snippet": block,
	}
}
