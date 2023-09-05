# METADATA
# title: "Verify API Gateway has X-Ray Tracing enabled"
# description: "It allows you to gain insights into the performance and behavior of your API Gateway endpoints, identify and troubleshoot latency issues, understand the flow of requests through your API, and diagnose errors and exceptions. X-Ray tracing provides valuable visibility into the execution of your API Gateway, helping you optimize performance, identify bottlenecks, and ensure a smooth and efficient API experience for your users."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage
# custom:
#   id: CB_TFAWS_081
#   severity: LOW
package lib.terraform.CB_TFAWS_081

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_api_gateway_stage"
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
    resource.Attributes.xray_tracing_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_api_gateway_stage' 'xray_tracing_enabled' is enabled.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_api_gateway_stage' 'xray_tracing_enabled' should be enabled.",
                "snippet": block }
}
