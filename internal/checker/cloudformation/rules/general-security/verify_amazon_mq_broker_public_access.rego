# METADATA
# title: "Verify Amazon MQ Broker does not have public access."
# description: "This policy restricts access to brokers without public accessibility to within your VPC, reducing vulnerability to DDoS attacks. Conversely, public Amazon MQ brokers are directly accessible outside VPCs, potentially exposing them to malicious activity."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amazonmq-broker.html
# custom:
#   id: CB_CFT_051
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_051

import future.keywords.in

resource := "AWS::AmazonMQ::Broker"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[broker] {
    is_valid
    some resources in input.Resources
    broker := resources.Properties
    broker.PubliclyAccessible == false
}

fail[resources] {
    some resources in input.Resources
    is_valid
    count(pass) == 0 
}

passed[result] {
	some block in pass
	result := {
		"message": "Amazon MQ Broker does not have public access.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Amazon MQ Broker has public access.",
		"snippet": block,
	}
}