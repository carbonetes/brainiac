# METADATA
# title: "Verify Redshift cluster is private."
# description: "This policy outlines access options for Redshift clusters within a VPC, including internet access, VPN-connected EC2 Instances, bastion hosts, and enabling the Publicly Accessible option. Enabling public access increases the risk of malicious activities such as SQL injections or DDoS attacks."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-cluster.html
# custom:
#   id: CB_CFT_063
#   severity: HIGH
package lib.cloudformation.CB_CFT_063
import future.keywords.in

resource := "AWS::Redshift::Cluster"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	properties := resources.Properties
    properties.PubliclyAccessible == false
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some properties in pass
	result := {
		"message": "Redshift Cluster  is not publicly accessible.",
		"snippet": properties,
	}
}

failed[result] {
	some properties in fail
	result := {
		"message": "Redshift Cluster is publicly accessible.",
		"snippet": properties,
	}
}
