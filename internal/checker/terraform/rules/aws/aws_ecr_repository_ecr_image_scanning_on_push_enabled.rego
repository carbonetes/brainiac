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


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ecr_repository"
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
    contains(resource.Blocks[_].Type, "image_scanning_configuration")
    has_attribute(resource.Blocks[_].Attributes, "scan_on_push")
    resource.Blocks[_].Attributes.scan_on_push == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "ECR image scanning on push is activated.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "ECR image scanning on push must be activated.",
                "snippet": block }
} 