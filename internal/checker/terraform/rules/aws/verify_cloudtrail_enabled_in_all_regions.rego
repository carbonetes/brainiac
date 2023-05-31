# METADATA
# title: "Verify CloudTrail is enabled in all Regions"
# description: "Enabling CloudTrail in all regions ensures that no AWS account activities go undocumented."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail
# custom:
#   id: CB_TFAWS_067
#   severity: LOW
package lib.terraform.CB_TFAWS_067


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudtrail"
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
    resource.Attributes.is_multi_region_trail = true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_cloudwatch_log_group' 'is_multi_region_trail' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_cloudwatch_log_group' 'is_multi_region_trail' should be set.",
                "snippet": block }
} 