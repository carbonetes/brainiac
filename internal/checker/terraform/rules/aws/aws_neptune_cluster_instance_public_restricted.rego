# METADATA
# title: "See to it that the Neptune Cluster instance is not accessible to the general public"
# description: "With Neptune, you can also take database snapshots that you can later utilize to recover a database from. An owner of the recipient account can use the snapshot you share with them to restore a database that contains your data. You can share a snapshot with another Amazon Web Services account. A database holding your data can be restored by anyone if you decide to make your snapshots public."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster_instance
# custom:
#   id: CB_TFAWS_071
#   severity: HIGH
package lib.terraform.CB_TFAWS_071

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_neptune_cluster_instance"
}

has_attribute(key, value) if {
	value in object.keys(key)
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
	has_attribute(resource.Attributes, "publicly_accessible")
	resource.Attributes.publicly_accessible == false
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Neptune cluster instance cannot be accessed publicly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Neptune cluster instance should not be available for public access.",
		"snippet": block,
	}
}