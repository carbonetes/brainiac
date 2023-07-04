# METADATA
# title: "Verify that Kubernetes Engine Cluster pod security policy is enforced"
# description: "By enforcing Pod Security Policies in a Kubernetes Engine Cluster, you can ensure enhanced security by defining and enforcing a set of security policies that govern the behavior and permissions of pods running within the cluster."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_cluster#is_pod_security_policy_enabled
# custom:
#   id: CB_TFOCI_028
#   severity: MEDIUM
package lib.terraform.CB_TFOCI_028

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "oci_containerengine_cluster"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
}

pass[resource] {
	resource := input[_]
    isvalid(resource)
    resource.Blocks[_].Type == "options"
    resource.Blocks[_].Blocks[_].Type == "admission_controller_options"
    resource.Blocks[_].Blocks[_].Attributes.is_pod_security_policy_enabled == true
}

pass[resource] {
	resource := input[_]
    isvalid(resource)
    resource.Blocks[_].Type == "options"
    resource.Blocks[_].Blocks[_].Type == "admission_controller_options"
    lower(resource.Blocks[_].Blocks[_].Attributes.is_pod_security_policy_enabled) == "true"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'oci_containerengine_cluster' for 'is_pod_security_policy_enabled' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'oci_containerengine_cluster' for 'is_pod_security_policy_enabled' should be set.",
                "snippet": block }
} 