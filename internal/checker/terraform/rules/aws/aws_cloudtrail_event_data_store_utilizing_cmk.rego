# METADATA
# title: "Require that the Cloud Trail Event Data Store utilizes a Customer Managed Key (CMK)"
# description: "The check validates whether the CloudTrail Event Data Store is utilizing a Customer Managed Key (CMK) to strengthen the encryption of critical data, bolstering security measures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail_event_data_store
# custom:
#   id: CB_TFAWS_284
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_284

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudtrail_event_data_store"
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "kms_key_id")
    resource.Attributes.kms_key_id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "A Customer Managed Key (CMK) is utilized by Cloud Trail Event Data Store.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "A Customer Managed Key (CMK) must be utilized by Cloud Trail Event Data Store.",
                "snippet": block }
} 