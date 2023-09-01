# METADATA
# title: "Verify that Guard Duty detector is enabled"
# description: "By enabling the GuardDuty detector by default in the Terraform configuration, potential security threats and vulnerabilities can be proactively identified and monitored, ensuring the ongoing protection and integrity of the AWS resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_detector
# custom:
#   id: CB_TFAWS_227
#   severity: LOW
package lib.terraform.CB_TFAWS_227

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_guardduty_detector"
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
    resource.Attributes.enable == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Guard Duty detector is enabled",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Guard Duty detector should be enabled",
                "snippet": block }
} 