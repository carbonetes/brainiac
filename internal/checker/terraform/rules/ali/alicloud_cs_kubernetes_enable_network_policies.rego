# METADATA
# title: "Verify Kubernetes Installs Either Terway or Flannel Plugin for Standard Policy Support"
# description: "This policy ensures that Kubernetes installations include either the Terway or Flannel plugin to support standard networking policies. These plugins enhance networking capabilities, enabling adherence to standard policies."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes
# custom:
#   id: CB_TFALI_011
#   severity: LOW
package lib.terraform.CB_TFALI_011

import future.keywords.in
import future.keywords.if

isvalid(block) {
	block.Type == "resource"
	"alicloud_cs_kubernetes" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not resource.Attributes.pod_vswitch_ids 
	not resource.Attributes.pod_cidr 
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "addons"
    not check_flannel_name(resource)
    check_terway_eniip_name(resource)
}

check_flannel_name(resource) if {
	not resource.Attributes.pod_cidr != ""
    some block in resource.Blocks
    block.Type == "addons"
    some name in block.Attributes.name
    name == "flannel"
}

check_terway_eniip_name(resource) if {
	resource.Attributes.pod_cidr != ""
    some block in resource.Blocks
    block.Type == "addons"
    some name in block.Attributes.name
	name == "terway-eniip"
    some net_ids in resource.Attributes.pod_vswitch_ids
    some worker_ids in resource.Attributes.worker_vswitch_ids
    some master_ids in resource.Attributes.master_vswitch_ids
    net_ids == worker_ids
    net_ids == master_ids
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Kubernetes installation includes either the Terway or Flannel plugin, providing support for standard networking policies as per the policy requirements.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Kubernetes installation does not include either the Terway or Flannel plugin. Add one of these plugins to ensure compliance with standard networking policies.",
		"snippet": block,
	}
}
