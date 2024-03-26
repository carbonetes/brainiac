# METADATA
# title: "Verify Amazon EKS control plane logging enabled for all log types"
# description: "EKS control plane logging provides visibility into cluster operations and can be used to detect potential security issues. The control plane log types are: api, audit, authenticators, controllerManager, and schedulers."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
# custom:
#   id: CB_TFAWS_034
#   severity: LOW
package lib.terraform.CB_TFAWS_034

import rego.v1

logtypes := ["api", "audit", "authenticators", "controllerManager", "schedulers"]

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
	logtypes := ["api", "audit", "authenticators", "controllerManager", "schedulers"]
	some resource in input
	isvalid(resource)
	resource.Attributes.enabled_cluster_log_types == logtypes
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_eks_cluster' 'enabled_cluster_log_types' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_eks_cluster' 'enabled_cluster_log_types' must be set to 'api, audit, authenticators, controllerManager, schedulers'.",
		"snippet": block,
	}
}
