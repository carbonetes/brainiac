# METADATA
# title: "Verify Redshift are using SSL"
# description: "This policy identifies Redshift databases where insecure data connections are being used, emphasizing the importance of SSL connections for secure data transit."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-clusterparametergroup.html
# custom:
#   id: CB_CFT_078
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_078
import future.keywords.in

resource := "AWS::Redshift::ClusterParameterGroup"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
	some params in properties.Parameters
    params.ParameterName == "require_ssl"
    params.ParameterValue == true
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Redshift is using SSL",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Redshift is not using SSL",
		"snippet": block,
	}
}
