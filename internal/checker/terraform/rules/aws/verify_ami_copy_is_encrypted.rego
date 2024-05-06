# METADATA
# title: "Verify that copied AMIs are encrypted"
# description: "By encrypting the copied AMIs, sensitive data stored within the images remains protected, ensuring the security and confidentiality of the resources deployed from those AMIs."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami_copy#encrypted
# custom:
#   id: CB_TFAWS_223
#   severity: LOW
package lib.terraform.CB_TFAWS_223
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    supported_resource := ["aws_elasticsearch_domain", "aws_opensearch_domain"]
    label == "aws_ami_copy"
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
    resource.Attributes.encrypted == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "AMI copy is encrypted",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "AMI copy should be encrypted",
                "snippet": block }
}
