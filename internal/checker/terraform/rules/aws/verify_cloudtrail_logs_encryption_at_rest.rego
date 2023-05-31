# METADATA
# title: "Verify CloudTrail logs are encrypted with a KMS key"
# description: "CloudTrail logs contain sensitive information about your AWS account. You should encrypt them at rest to prevent unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail
# custom:
#   id: CB_TFAWS_032
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_032

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudtrail"
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
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_cloudtrail' 'kms_key_id' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_cloudtrail' 'kms_key_id' is not set properly.",
                "snippet": block }
} 