# METADATA
# title: "Verify that Amazon EKS cluster endpoint public access is disabled"
# description: "An Amazon EKS cluster endpoint is a network interface in a subnet that you use to communicate with your cluster control plane. Amazon EKS creates an endpoint for your cluster in each subnet associated with the cluster. The cluster endpoint is the same for all subnets. By default, the cluster endpoint is public to the internet. You can disable public access to the cluster endpoint by setting the endpointPublicAccess property to false."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
# custom:
#   id: CB_TFAWS_045
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_045

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_eks_cluster"
}

has_attribute(key, value) if {
	value in object.keys(key)
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
	some blocks in resource.Blocks
	has_attribute(blocks.Attributes, "endpoint_public_access")
	blocks.Attributes.endpoint_public_access == false
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_eks_cluster' 'endpoint_public_access' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_eks_cluster' 'endpoint_public_access' must be set to 'false'.",
		"snippet": block,
	}
}
