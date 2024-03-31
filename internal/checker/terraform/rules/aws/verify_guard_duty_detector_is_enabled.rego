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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_guardduty_detector"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if {
    some resource in input
	isvalid(resource)
    resource.Attributes.enable == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Guard Duty detector is enabled",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Guard Duty detector should be enabled",
                "snippet": block }
} 