# METADATA
# title: "Verify AWS Config is enabled in all regions"
# description: "Enabling AWS Config in all regions enhances your security and compliance posture by providing visibility and control over your AWS environment on a global scale."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_aggregator.html
# custom:
#   id: CB_TFAWS_116
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_116

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_config_configuration_aggregator"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    sources := ["account_aggregation_source", "organization_aggregation_source"]
    block.Type == sources[_]
    block.Attributes.all_regions == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_config_configuration_aggregator' Config is enabled in all regions",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_config_configuration_aggregator' Config should be enabled in all regions",
                "snippet": block }
}
