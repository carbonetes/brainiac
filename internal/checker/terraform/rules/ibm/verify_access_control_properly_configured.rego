# METADATA
# title: "Verify Access Control is properly configured"
# description: "This policy ensures proper access control in Terraform configurations by checking for the presence of the app_version and tags attributes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/app
# custom:
#   id: CB_TFIBM_011
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_011
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
    label == "ibm_app"
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
    attribute := block.Attributes
    "app_version" in object.keys(attribute)
  	version := attribute.app_version
	version != "1.0"

}

fail contains block if {
	some block in input
	isvalid(block)
    attribute := block.Attributes
    "tags" in object.keys(attribute)
    some tag in attribute.tags
    tag == ""
}

pass contains resource if {
	some resource in input
	isvalid(resource)
    not fail[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "The API key and project ID exist and not null",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "The API key and project ID should be exist and not null",
		"snippet": block,
	}
}