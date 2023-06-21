# METADATA
# title: "Verify that Redshift cluster allowing version upgrade by default"
# description: "By encrypting an Amazon Redshift cluster with AWS KMS, sensitive data stored within the cluster is protected, ensuring the confidentiality and integrity of the information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster#kms_key_id
# custom:
#   id: CB_TFAWS_145
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_145

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_redshift_cluster"
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

pass[resource] {
	resource := input[_]
    isvalid(resource)
    has_attribute(resource.Attributes, "kms_key_id")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_redshift_cluster' for 'kms_key_id' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_redshift_cluster' for 'kms_key_id' should be set.",
                "snippet": block }
} 