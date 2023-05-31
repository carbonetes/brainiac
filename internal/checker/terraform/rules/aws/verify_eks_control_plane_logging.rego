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

logTypes := [
    "api",
    "audit",
    "authenticators",
    "controllerManager",
    "schedulers"
   ]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_eks_cluster"
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
    resource.Attributes.enabled_cluster_log_types == logTypes
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_eks_cluster' 'enabled_cluster_log_types' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_eks_cluster' 'enabled_cluster_log_types' must be set to 'api, audit, authenticators, controllerManager, schedulers'.",
                "snippet": block }
} 