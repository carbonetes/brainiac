# METADATA
# title: "Verify Elastic Beanstalk environments have enhanced health reporting enabled"
# description: "Verifying that Elastic Beanstalk environments have enhanced health reporting enabled ensures improved monitoring and diagnostics for applications."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elastic_beanstalk_environment
# custom:
#   id: CB_TFAWS_295
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_295

import future.keywords.if

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_elastic_beanstalk_environment"
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
    resource.Blocks[_].Type == "setting"
    value := resource.Blocks[_].Attributes
    validValue(value)
}

validValue(attrib) := result if {
	attrib.namespace == "aws:elasticbeanstalk:healthreporting:system"
    attrib.name == "HealthStreamingEnabled"
    attrib.value == true
    result := true
} else := result if {
	attrib.namespace == "aws:elasticbeanstalk:healthreporting:system"
    attrib.name == "HealthStreamingEnabled"
    attrib.value == "true"
    result := true
} else := result if {
    result := false
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Elastic Beanstalk environments have enhanced health reporting enabled.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Elastic Beanstalk setting must have health reporting enabled.",
                "snippet": block }
}
