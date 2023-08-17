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

supportedResources := ["aws_autoscaling_group","aws_lb_target_group"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getTheLabelforAwsAutoscalingGroup[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_autoscaling_group"
    resource.Attributes.health_check_type == "ELB"
    label := concat(".", resource.Labels)
}

getTheLabelforAwsElb[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_elb"
    resource.Blocks[_].Type == "health_check"
    label := concat(".", resource.Labels)
}

isValidResourceAttached{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_autoscaling_attachment"
    awsAutoscalingGroupLabel := getTheLabelforAwsAutoscalingGroup[_]
    awsElbLabel := getTheLabelforAwsElb[_]
    contains(resource.Attributes.autoscaling_group_name, awsAutoscalingGroupLabel)
    contains(resource.Attributes.elb, awsElbLabel)
}

pass[resource]{
    resource := input[_]
    isvalid(resource)
    isValidResourceAttached
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The Elastic Load Balancing health checks are being utilized by auto scaling groups connected to load balancers.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The Elastic Load Balancing health checks must be utilized by auto scaling groups connected to load balancers.",
                "snippet": block }
} 