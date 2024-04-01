# METADATA
# title: "Verify that ECR image scanning on push is activated"
# description: "Amazon ECR is a fully managed container registry used to store, manage and deploy container images. ECR Image Scanning assesses and identifies operating system vulnerabilities. Using automated image scans you can ensure container image vulnerabilities are found before getting pushed to production."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository
# custom:
#   id: CB_TFAWS_155
#   severity: HIGH
package lib.terraform.CB_TFAWS_155
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_ecr_repository"
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
    some res in resource.Blocks
    contains(res.Type, "image_scanning_configuration")
    has_attribute(res.Attributes, "scan_on_push")
    res.Attributes.scan_on_push == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "ECR image scanning on push is activated.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "ECR image scanning on push must be activated.",
                "snippet": block }
} 