# METADATA
# title: "For the Lambda environmental variable, verify the encryption settings"
# description: "By enforcing appropriate encryption settings, organizations can enhance the overall security of their Lambda functions and protect sensitive information from unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.1.0/docs/resources/lambda_function
# custom:
#   id: CB_TFAWS_165
#   severity: LOW
package lib.terraform.CB_TFAWS_165
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_lambda_function"
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
    has_attribute(resource.Attributes, "kms_key_arn")
    resource.Attributes.kms_key_arn != ""
    some block in resource.Blocks
    contains(block.Type, "environment")
}


fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Encryption settings are enforced for the lambda environmental variable.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Encryption settings must be enforced for the lambda environmental variable.",
                "snippet": block }
} 