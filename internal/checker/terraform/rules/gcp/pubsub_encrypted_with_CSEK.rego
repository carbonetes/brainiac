# METADATA
# title: "Verify PubSub Topics are encrypted with Customer Supplied Encryption Keys (CSEK)"
# description: "This ensures that data in Google Cloud Pub/Sub topics is encrypted using keys provided by the customer, enhancing control and security over message confidentiality."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic
# custom:
#   id: CB_TFGCP_085
#   severity: LOW
package lib.terraform.CB_TFGCP_085
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_pubsub_topic" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
    some block in input
	isvalid(block)
	block.Attributes.kms_key_name != ""
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "PubSub Topics are encrypted with Customer Supplied Encryption Keys (CSEK).",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "PubSub Topics should be encrypted with Customer Supplied Encryption Keys (CSEK).",
                "snippet": block }
}