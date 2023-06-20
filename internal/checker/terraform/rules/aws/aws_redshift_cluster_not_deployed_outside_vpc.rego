# METADATA
# title: "Verify that Redshift is not set up outside of a VPC"
# description: "A virtual private cloud, or VPC, is a virtual network separate from other virtual networks on the AWS cloud. Using security groups and network access control lists (NACLs), you may manage the inbound and outgoing network traffic to and from your Redshift cluster when you deploy Redshift in a VPC. This can enhance the security of your Redshift cluster and guard it against intrusions or attacks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster
# custom:
#   id: CB_TFAWS_139
#   severity: LOW
package lib.terraform.CB_TFAWS_139

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_redshift_cluster"
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
    has_attribute(resource.Attributes, "cluster_subnet_group_name")
    resource.Attributes.cluster_subnet_group_name != ""
}


fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_redshift_cluster' Redshift is not set up outside of a VPC.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_redshift_cluster' Redshift must not be set up outside of a VPC.",
                "snippet": block }
} 