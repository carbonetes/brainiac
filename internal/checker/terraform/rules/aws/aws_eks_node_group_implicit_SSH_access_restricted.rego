# METADATA
# title: "Make certain that 0.0.0.0/0 does not automatically have SSH access to the AWS EKS node group"
# description: "Maintaining a robust security posture involves ensuring that your AWS EKS node group does not allow unrestricted SSH access from 0.0.0.0/0. By implementing this measure, you minimize the risk of unauthorized SSH connections originating from the internet, enhancing the overall security of your environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group
# custom:
#   id: CB_TFAWS_112
#   severity: HIGH
package lib.terraform.CB_TFAWS_112

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_eks_node_group"
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
	some remoteaccess in resource.Blocks
	remoteaccess.Type == "remote_access"
	has_attribute(remoteaccess.Attributes, "source_security_group_ids")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "AWS EKS node group does not allow unrestricted SSH access from 0.0.0.0/0.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "AWS EKS node group should not allow unrestricted SSH access from 0.0.0.0/0.",
		"snippet": block,
	}
}