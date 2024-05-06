# METADATA
# title: "Verify that detailed monitoring is enabled for EC2 instances"
# description: "With detailed monitoring, you can accurately monitor resource utilization, identify performance bottlenecks, and make informed decisions for scaling and optimizing your EC2 infrastructure."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#monitoring
# custom:
#   id: CB_TFAWS_123
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_123
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in  block.Labels 
    label == "aws_instance"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if{
    some resource in input
    isvalid(resource)
    resource.Attributes.monitoring == true
}

fail contains block if {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_instance' monitoring is enabled",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_instance' 'monitoring' should be set to true",
                "snippet": block}
}
