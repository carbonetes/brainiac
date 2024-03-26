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

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_eks_cluster"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some encryption_config in resource.Blocks
	encryption_config.Type == "encryption_config"
	some secrets_block in encryption_config.Blocks
	secrets_block.Type == "secrets"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "aws_eks_cluster encryption is set to true.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "aws_eks_cluster encryption should be set to true.",
		"snippet": block,
	}
}