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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_redshift_cluster"
}

has_attribute(key, value) if {
    value in object.keys(key)
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if {
    some resource in input
	isvalid(resource)
    has_attribute(resource.Attributes, "cluster_subnet_group_name")
    resource.Attributes.cluster_subnet_group_name != ""
}


fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_redshift_cluster' Redshift is not set up outside of a VPC.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_redshift_cluster' Redshift must not be set up outside of a VPC.",
                "snippet": block }
} 