# METADATA
# title: "Verify timing for application deployment is set"
# description: "This policy aims to prevent potential issues by detecting attempts to manually enable database partitioning, which may be unnecessary or could lead to misconfigurations in a managed service environment like IBM Cloudant."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cloudant_database
# custom:
#   id: CB_TFIBM_063
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_063
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
    label == "ibm_cloudant_database"
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

fail contains block if {
	some block in input
	isvalid(block)
	res := block.Attributes
    "partitioned" in object.keys(res)
    res.partitioned != false
}

passed contains result if {
	some block in pass
	result := {
		"message": "Partition Configuration is set to false",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Partition Configuration must be set to false",
		"snippet": block,
	}
}