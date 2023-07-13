# METADATA
# title: "Check that the API Gateway Domain utilizes a current security policy"
# description: "The security policy can be defined in the AWS API Gateway Domain. You can employ unreliable cypher suites when using TLS 1_0."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_domain_name
# custom:
#   id: CB_TFAWS_205
#   severity: LOW
package lib.terraform.CB_TFAWS_205

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_api_gateway_domain_name"
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
    has_attribute(resource.Attributes, "security_policy")
    resource.Attributes.security_policy == "TLS_1_2"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Current security policy is utilized by the API Gateway Domain.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Current security policy must be utilized by the API Gateway Domain.",
                "snippet": block }
} 