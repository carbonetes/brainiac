# METADATA
# title: "Verify Instance Metadata Service Version 1 are  disabled"
# description: "This policy allows code on an instance to securely access instance metadata through the Instance Metadata Service (IMDS). Two methods are available: IMDSv1, which is prone to local misconfigurations, and IMDSv2, which offers a session-oriented approach."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate.html
# custom:
#   id: CB_CFT_057
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_057

import future.keywords.in

resource := "AWS::EC2::LaunchTemplate"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[http] {
    is_valid
    some resources in input.Resources
    resources.Type == resource
    http := resources.Properties.LaunchTemplateData.MetadataOptions
    http.HttpEndpoint == "disabled"
    http.HttpTokens == "required"
}

fail[resources] {
    some resources in input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
    some block in pass
    result := {
        "message": "Instance Metadata Service Version 1 is not enabled.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Instance Metadata Service Version 1 is enabled.",
        "snippet": block,
    }
}