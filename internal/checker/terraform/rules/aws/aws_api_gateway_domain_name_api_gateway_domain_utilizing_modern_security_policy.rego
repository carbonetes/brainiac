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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_api_gateway_domain_name"
}

has_attribute(key, value) if {
    value in object.keys(key)
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
    has_attribute(resource.Attributes, "security_policy")
    resource.Attributes.security_policy == "TLS_1_2"
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Current security policy is utilized by the API Gateway Domain.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Current security policy must be utilized by the API Gateway Domain.",
                "snippet": block }
} 