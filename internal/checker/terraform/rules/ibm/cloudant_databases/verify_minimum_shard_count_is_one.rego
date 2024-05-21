# METADATA
# title: "Verify minimum shard count is 1"
# description: "This policy verifies compliance with the minimum shard count requirement, aiming to prevent misconfigurations or invalid settings that may compromise the performance or intended use of the IBM Cloudant database service."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cloudant_database
# custom:
#   id: CB_TFIBM_064
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_064
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
    "shards" in object.keys(res)
    res.shards < 1
}

passed contains result if {
	some block in pass
	result := {
		"message": "Minimum shard count is not less than 1",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Minimum shard count is less than 1",
		"snippet": block,
	}
}