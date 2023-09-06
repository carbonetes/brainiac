# METADATA
# title: "Make sure Secrets Encryption is enabled in the EKS Cluster"
# description: "Enforce secrets encryption for AWS EKS cluster, ensuring that the encryption configuration is properly enabled. This Terraform code verifies the presence of correct encryption settings, adding an extra layer of security to protect sensitive information within the EKS cluster."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
# custom:
#   id: CB_TFAWS_056
#   severity: LOW
package lib.terraform.CB_TFAWS_056

supportedResource := ["aws_eks_cluster"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource] {
    resource := input[_]
    isvalid(resource)
    encryption_config := resource.Blocks[_]
    encryption_config.Type == "encryption_config"
    secrets_block := encryption_config.Blocks[_]
    secrets_block.Type == "secrets"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "aws_eks_cluster encryption is set to true.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "aws_eks_cluster encryption should be set to true.",
                "snippet": block}
}
