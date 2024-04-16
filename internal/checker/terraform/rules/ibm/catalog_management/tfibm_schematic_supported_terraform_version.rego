# METADATA
# title: "Verify schematic is using supported Terraform versions"
# description: "This policy mandates verifying that all schematics conform to Terraform's supported versions, ensuring compatibility and stability in infrastructure deployments."
# scope: package
# related_resources:
# - registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_validation
# custom:
#   id: CB_TFIBM_036
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_036

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cm_validation", "cm_version_validation"]
	label in supported_resource
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
	attribute := resource.Attributes
	schem := attribute.schematics
    values := ["v1.5.7", "v1.4.6", "v1.3.6"]
    schem.terraform_version in values
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Schematics is using supported version",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Schematics is not using supported version",
		"snippet": block,
	}
}