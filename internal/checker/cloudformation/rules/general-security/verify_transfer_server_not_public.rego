# METADATA
# title: "Verify Transfer Server are not exposed to public"
# description: "This policy ensures that your Azure Transfer Server isn't public, thereby protecting your data from unauthorized access or tampering. Public servers are vulnerable to external threats like hackers or malware, while a private setting restricts access to authorized users only, enhancing security."
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-transfer-server.html
# custom:
#   id: CB_CFT_103
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_103
import future.keywords.in

resource := "AWS::Transfer::Server"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    some resource in input.Resources
    properties := resource.Properties
	"EndpointType" in object.keys(properties)
    endpoint_values := ["VPC", "VPC_ENDPOINT"]
    properties.EndpointType in endpoint_values
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Transfer Server is not exposed to public.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Transfer Server is exposed public.",
		"snippet": block,
	}
}