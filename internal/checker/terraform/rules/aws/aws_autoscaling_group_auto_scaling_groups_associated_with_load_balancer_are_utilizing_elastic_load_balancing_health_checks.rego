# METADATA
# title: "Verify that Elastic Load Balancing health checks are being utilized by auto scaling groups connected to load balancers"
# description: "Verify that your Amazon Auto Scaling Groups are linked to Elastic Load Balancers in excellent condition to preserve the availability of the compute resources in the case of an error and offer an equally divided application load."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/autoscaling_group.html
# custom:
#   id: CB_TFAWS_348
#   severity: LOW
package lib.terraform.CB_TFAWS_348

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_autoscaling_attachment"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getthelabelforawsautoscalinggroup contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_autoscaling_group" in resource.Labels
	resource.Attributes.health_check_type == "ELB"
	label := concat(".", resource.Labels)
}

getthelabelforawselb contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_elb" in resource.Labels
	label := concat(".", resource.Labels)
}

gettheattributeforawselb if {
	some resource in input
	resource.Type == "resource"
	"aws_elb" in resource.Labels
	some block in resource.Blocks
	block.Type == "health_check"
}

isawsautoscalingattachedforag if {
	some resource in input
	resource.Type == "resource"
	"aws_autoscaling_attachment" in resource.Labels
	some label in getthelabelforawsautoscalinggroup
	contains(resource.Attributes.autoscaling_group_name, label)
}

isawsautoscalinggroupattachedforelb if {
	some resource in input
	resource.Type == "resource"
	"aws_autoscaling_attachment" in resource.Labels
	some label in getthelabelforawselb
	contains(resource.Attributes.elb, label)
}

isvalidattachments := false if {
	isawsautoscalinggroupattachedforelb
	isawsautoscalingattachedforag
	not gettheattributeforawselb
} else if {
	not isawsautoscalinggroupattachedforelb
	isawsautoscalingattachedforag
} else if {
	isawsautoscalinggroupattachedforelb
	isawsautoscalingattachedforag
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	isvalidattachments
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "The Elastic Load Balancing health checks are being utilized by auto scaling groups connected to load balancers.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "The Elastic Load Balancing health checks must be utilized by auto scaling groups connected to load balancers.",
		"snippet": block,
	}
}
